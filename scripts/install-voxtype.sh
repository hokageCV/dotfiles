#!/usr/bin/env bash
set -euo pipefail

VOXTYPE_VERSION="1.0.1"
RPM_URL="https://github.com/peteonrails/voxtype/releases/download/v${VOXTYPE_VERSION}/voxtype-${VOXTYPE_VERSION}-1.x86_64.rpm"
RPM_FILE="/tmp/voxtype-${VOXTYPE_VERSION}-1.x86_64.rpm"

echo "==> Installing Voxtype v${VOXTYPE_VERSION}"

# Step 1: Download and install RPM
if command -v voxtype &>/dev/null; then
  echo "Voxtype already installed: $(voxtype --version 2>/dev/null || true)"
  echo "Reinstalling..."
fi

echo "Downloading RPM..."
wget -q --show-progress -O "$RPM_FILE" "$RPM_URL"
sudo dnf install -y "$RPM_FILE"
rm -f "$RPM_FILE"
echo "RPM installed."

# Step 2: Add user to input group (for evdev hotkey detection)
if groups "$USER" | grep -qw input; then
  echo "User already in 'input' group."
else
  echo "Adding $USER to 'input' group..."
  sudo usermod -aG input "$USER"
  echo "Done. You must log out and back in for this to take effect."
fi

# Step 3: Download default Whisper model
echo "Setting up Whisper model..."
voxtype setup --download

# Step 4: Start the daemon
# NOT enabled at boot via systemd: voxtype's unit is WantedBy=graphical-session.target,
# which never fires on Hyprland. It's started by Hyprland's exec-once (auto-start.conf)
# so the daemon inherits WAYLAND_DISPLAY and the OSD can render.
echo "Starting voxtype daemon..."
systemctl --user start voxtype

echo ""
echo "==> Voxtype installed successfully."
echo "    Run 'voxtype info' to verify."
echo "    Hotkey (F5 PTT) and GPU setup: run 'voxtype configure' or ask for help."
