#!/bin/bash
set -euo pipefail

EH_REL="release-20250915"
EH_FILE="evil-helix-amd64-linux.tar.gz"
DOWNLOAD_URL="https://github.com/usagi-flow/evil-helix/releases/download/${EH_REL}/${EH_FILE}"

echo "=== Installing Evil Helix ==="

pkill -x hx 2>/dev/null || true

cd /tmp
curl -fLO "$DOWNLOAD_URL"

sudo rm -rf /opt/evil-helix
sudo mkdir -p /opt/evil-helix
sudo tar -xzf "$EH_FILE" -C /opt/evil-helix --strip-components=1
sudo ln -svf /opt/evil-helix/hx /usr/local/bin/hx

# Create runtime link in config directory
mkdir -p ~/.config/helix
ln -snvf /opt/evil-helix/runtime ~/.config/helix/runtime

rm -f "$EH_FILE"

echo "✓ Evil Helix installed."
exho "run 'stow evil-helix'"
hx --version

: <<'UNINSTALL_HELIX'
pkill -x hx 2>/dev/null || true
sudo rm -f /usr/local/bin/hx
sudo rm -rf /opt/evil-helix
rm -f ~/dotfiles/helix/.config/helix/runtime
rm -f ~/.config/helix/runtime 2>/dev/null || true
rm -f /tmp/evil-helix-amd64-linux.tar.gz 2>/dev/null || true
which helix 2>/dev/null && echo "Standard helix still available at: $(which helix)"
echo "=== Evil Helix completely uninstalled ==="
UNINSTALL_HELIX
