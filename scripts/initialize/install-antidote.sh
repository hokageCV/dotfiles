#!/usr/bin/env bash
set -e

DOTFILES_DIR="$HOME/dotfiles"
ANTIDOTE_PATH="zsh/.config/zsh/antidote"
ANTIDOTE_REPO="https://github.com/mattmc3/antidote.git"

cd "$DOTFILES_DIR"

if [ -d "$ANTIDOTE_PATH/.git" ]; then
  echo "✔ Antidote submodule already exists. Skipping."
  exit 0
fi

git submodule add "$ANTIDOTE_REPO" "$ANTIDOTE_PATH"
git submodule update --init --recursive

echo "✔ Antidote installed as submodule at:"
echo "  $ANTIDOTE_PATH"
