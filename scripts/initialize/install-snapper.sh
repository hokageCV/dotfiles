#!/usr/bin/env bash
set -euo pipefail

# install-snapper.sh — Snapper + grub-btrfs + btrfs-assistant on Fedora (dnf5)
#
# Scope: root (/) only. ~1 day of rollback history.
# - Timeline: hourly x12 + daily x1, weekly/monthly/yearly 0
# - Numbered (dnf pre/post): keep 10, important 5
#
# Idempotent: safe to re-run. Uses sudo per command (do not run as root).

if [[ "${EUID}" -eq 0 ]]; then
  echo "Run as a normal user (script uses sudo itself)."
  exit 1
fi

if ! findmnt -n -o FSTYPE / | grep -q btrfs; then
  echo "Error: / is not btrfs. Snapper setup does not apply."
  exit 1
fi

REAL_USER="${SUDO_USER:-$USER}"

echo "==> [1/6] Installing packages..."
for pkg in snapper inotify-tools btrfs-assistant libdnf5-plugin-actions; do
  if rpm -q "$pkg" &>/dev/null; then
    echo "✔ $pkg"
  else
    echo "➕ Installing $pkg"
    sudo dnf install -y "$pkg"
  fi
done

echo "==> [2/6] Creating snapper config for / ..."
if snapper list-configs 2>/dev/null | grep -qw root; then
  echo "✔ snapper config 'root' exists"
else
  sudo snapper -c root create-config /
  echo "✔ created snapper config 'root'"
fi
sudo restorecon -RF /.snapshots 2>/dev/null || true

echo "==> [3/6] Tuning retention (~1 day) ..."
# Timeline: ~24h of hourlies + yesterday. Numbered: last ~10 dnf transactions.
sudo snapper -c root set-config \
  ALLOW_USERS="$REAL_USER" SYNC_ACL=yes \
  TIMELINE_CREATE=yes TIMELINE_CLEANUP=yes TIMELINE_MIN_AGE=1800 \
  TIMELINE_LIMIT_HOURLY=12 TIMELINE_LIMIT_DAILY=1 \
  TIMELINE_LIMIT_WEEKLY=0 TIMELINE_LIMIT_MONTHLY=0 TIMELINE_LIMIT_YEARLY=0 \
  NUMBER_CLEANUP=yes NUMBER_LIMIT=10 NUMBER_LIMIT_IMPORTANT=5 \
  EMPTY_PRE_POST_CLEANUP=yes EMPTY_PRE_POST_MIN_AGE=1800 \
  SPACE_LIMIT=0.5
sudo systemctl enable --now snapper-timeline.timer snapper-cleanup.timer

# Keep locate out of snapshots
if grep -q '^PRUNENAMES' /etc/updatedb.conf 2>/dev/null; then
  if ! grep -q '\.snapshots' /etc/updatedb.conf; then
    sudo sed -i 's|^PRUNENAMES *= *"|PRUNENAMES = ".snapshots |' /etc/updatedb.conf
    echo "✔ updatedb PRUNENAMES patched"
  fi
else
  echo 'PRUNENAMES = ".snapshots"' | sudo tee -a /etc/updatedb.conf >/dev/null
fi

echo "==> [4/6] dnf5 pre/post snapshot hooks ..."
sudo tee /usr/local/bin/dnf-snapper-pre >/dev/null <<'EOF'
#!/bin/bash
# Creates a pre snapshot; stashes its number for the post hook.
snapper -c root create -t pre -p -c number -d "dnf transaction" > /run/snapper-dnf-pre
EOF
sudo tee /usr/local/bin/dnf-snapper-post >/dev/null <<'EOF'
#!/bin/bash
[ -s /run/snapper-dnf-pre ] || exit 0
snapper -c root create -t post --pre-number "$(cat /run/snapper-dnf-pre)" -c number -d "dnf transaction"
rm -f /run/snapper-dnf-pre
EOF
sudo chmod 755 /usr/local/bin/dnf-snapper-pre /usr/local/bin/dnf-snapper-post
sudo restorecon -v /usr/local/bin/dnf-snapper-pre /usr/local/bin/dnf-snapper-post 2>/dev/null || true
sudo mkdir -p /etc/dnf/libdnf5-plugins/actions.d/
sudo tee /etc/dnf/libdnf5-plugins/actions.d/snapper.actions >/dev/null <<'EOF'
pre_transaction::::/usr/local/bin/dnf-snapper-pre
post_transaction::::/usr/local/bin/dnf-snapper-post
EOF
echo "✔ dnf5 actions installed"

echo "==> [5/6] grub-btrfs (boot menu rollback) ..."
if ! sudo dnf copr list --enabled 2>/dev/null | grep -q 'kylegospo/grub-btrfs'; then
  sudo dnf copr enable -y kylegospo/grub-btrfs
fi
if rpm -q grub-btrfs &>/dev/null; then
  echo "✔ grub-btrfs"
else
  sudo dnf install -y grub-btrfs
fi
# Generate snapshot submenu + main grub.cfg (Fedora path)
sudo /etc/grub.d/41_snapshots-btrfs || true
sudo grub2-mkconfig -o /boot/grub2/grub.cfg

# Stock grub-btrfs.path is broken on Fedora: BindsTo=/.snapshots.mount
# never exists (/.snapshots is a subvolume, not a mount). Use our own watcher.
sudo tee /etc/systemd/system/grub-btrfs-watch.path >/dev/null <<'EOF'
[Unit]
Description=Watch /.snapshots and refresh the GRUB snapshot menu

[Path]
PathModified=/.snapshots
Unit=grub-btrfs.service

[Install]
WantedBy=multi-user.target
EOF
sudo systemctl daemon-reload
sudo systemctl enable --now grub-btrfs-watch.path
# Never enable the broken stock unit
sudo systemctl disable --now grub-btrfs.path 2>/dev/null || true

echo "==> [6/6] Verifying ..."
snapper list-configs
sudo snapper -c root list | head -n 10 || true
sudo systemctl is-active snapper-timeline.timer snapper-cleanup.timer grub-btrfs-watch.path || true
ls -l /boot/grub2/grub-btrfs.cfg 2>/dev/null || echo "(grub-btrfs.cfg appears after first snapshot)"

echo ""
echo "✅ Snapper ready (root only, ~1 day retention)."
echo "   Manual snapshot:  sudo snapper -c root create --description \"baseline\""
echo "   List:             sudo snapper -c root list"
echo "   Rollback:         boot snapshot from GRUB → sudo snapper -c root rollback <N> → reboot"
echo "   GUI:              btrfs-assistant"
echo "   NOTE: /boot is ext4, so kernels are NOT rolled back (root files only)."
