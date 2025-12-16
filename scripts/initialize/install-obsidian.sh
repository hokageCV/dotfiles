#!/usr/bin/env bash
set -euo pipefail

FLATPAK_REMOTE="flathub"
APP_ID="md.obsidian.Obsidian"

echo "🔧 Installing Obsidian (Flatpak)"

if ! command -v flatpak >/dev/null; then
  echo "❌ flatpak is not installed"
  echo "   Install flatpak first, then rerun this script."
  exit 1
fi

if flatpak remotes | awk '{print $1}' | grep -qx "$FLATPAK_REMOTE"; then
  echo "✔ Flathub remote already exists"
else
  echo "➕ Adding Flathub remote"
  sudo flatpak remote-add --if-not-exists "$FLATPAK_REMOTE" \
    https://flathub.org/repo/flathub.flatpakrepo
fi

if flatpak info "$APP_ID" >/dev/null 2>&1; then
  echo "✔ Obsidian already installed"
else
  echo "➕ Installing Obsidian"
  flatpak install -y "$FLATPAK_REMOTE" "$APP_ID"
fi

if ! flatpak info "$APP_ID" >/dev/null 2>&1; then
  echo "❌ Obsidian install failed"
  exit 1
fi

echo "✅ Obsidian installed successfully"
echo "Run with: flatpak run $APP_ID"
