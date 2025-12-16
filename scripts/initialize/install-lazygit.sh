#!/usr/bin/env bash
set -euo pipefail

# source
# https://github.com/jesseduffield/lazygit?tab=readme-ov-file#fedora--amazon-linux-2023--centos-stream

COPR="dejan/lazygit"
PKG="lazygit"

echo "🔧 Installing lazygit via Copr"

# --------------------------------------------------
# 1. Enable Copr (idempotent)
# --------------------------------------------------
if dnf copr list --enabled | grep -q "$COPR"; then
  echo "✔ Copr already enabled: $COPR"
else
  echo "➕ Enabling Copr: $COPR"
  sudo dnf copr enable -y "$COPR"
fi

# --------------------------------------------------
# 2. Install lazygit
# --------------------------------------------------
if rpm -q "$PKG" &>/dev/null; then
  echo "✔ lazygit already installed"
else
  echo "➕ Installing lazygit"
  sudo dnf install -y "$PKG"
fi

# --------------------------------------------------
# 3. Verify
# --------------------------------------------------
if ! command -v lazygit >/dev/null; then
  echo "❌ lazygit install failed"
  exit 1
fi

echo "✅ lazygit installed successfully"
lazygit --version

