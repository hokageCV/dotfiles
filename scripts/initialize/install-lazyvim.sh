#!/usr/bin/env bash
set -euo pipefail

# source
# http://www.lazyvim.org/installation

NVIM_CONFIG="$HOME/.config/nvim"
BACKUP_SUFFIX=".bak.$(date +%s)"

echo "🔧 Installing LazyVim starter"

# --------------------------------------------------
# 1. Preconditions
# --------------------------------------------------
if ! command -v nvim >/dev/null; then
  echo "❌ neovim is not installed"
  exit 1
fi

if ! command -v git >/dev/null; then
  echo "❌ git is not installed"
  exit 1
fi

# --------------------------------------------------
# 2. Backup existing Neovim directories (if present)
# --------------------------------------------------
for dir in \
  "$HOME/.config/nvim" \
  "$HOME/.local/share/nvim" \
  "$HOME/.local/state/nvim" \
  "$HOME/.cache/nvim"; do
  if [[ -e "$dir" ]]; then
    echo "📦 Backing up $dir → ${dir}${BACKUP_SUFFIX}"
    mv "$dir" "${dir}${BACKUP_SUFFIX}"
  fi
done

# --------------------------------------------------
# 3. Clone LazyVim starter
# --------------------------------------------------
echo "➕ Cloning LazyVim starter"
git clone https://github.com/LazyVim/starter "$NVIM_CONFIG"

# --------------------------------------------------
# 4. Remove upstream git history
# --------------------------------------------------
echo "🧹 Removing upstream .git directory"
rm -rf "$NVIM_CONFIG/.git"

# --------------------------------------------------
# 5. Final instructions
# --------------------------------------------------
echo "✅ LazyVim installed successfully"
echo
echo "Next steps:"
echo "  1. Run: nvim"
echo "  2. Let plugins install"
echo "  3. Reopen nvim"
echo
echo "Backups were created with suffix: $BACKUP_SUFFIX"
