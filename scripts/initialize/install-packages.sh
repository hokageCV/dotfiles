#!/usr/bin/env bash
set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"
source "$DIR/packages.sh"

# ----------------------------
# Enable repos
# ----------------------------

for repo in "${REPOS[@]}"; do
  case "$repo" in
    rpmfusion)
      echo "➕ Enabling RPM Fusion"
      sudo dnf install -y \
        https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
        https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
      ;;
    copr:*)
      COPR_NAME="${repo#copr:}"
      echo "➕ Enabling COPR: $COPR_NAME"
      sudo dnf copr enable -y "$COPR_NAME"
      ;;
    *)
      echo "❌ Unknown repo format: $repo"
      exit 1
      ;;
  esac
done

# ----------------------------
# Install packages
# ----------------------------

for pkg in "${PACKAGES[@]}"; do
  if rpm -q "$pkg" &>/dev/null; then
    echo "✔ $pkg"
  else
    echo "➕ Installing $pkg"
    sudo dnf install -y "$pkg"
  fi
done

echo "✅ All packages installed"


