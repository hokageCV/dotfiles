#!/usr/bin/env bash
set -euo pipefail

TARGET_SHELL="/usr/bin/zsh"
ZSH_DIR="$HOME/.oh-my-zsh"
ZSHRC="$HOME/.zshrc"

echo "🔧 Setting up zsh + Oh My Zsh"

# --------------------------------------------------
# 1. Ensure zsh exists
# --------------------------------------------------
if [[ ! -x "$TARGET_SHELL" ]]; then
  echo "❌ zsh not found at $TARGET_SHELL"
  echo "   Install zsh first, then rerun this script."
  exit 1
fi

# Ensure zsh is an allowed shell
if ! grep -qx "$TARGET_SHELL" /etc/shells; then
  echo "❌ $TARGET_SHELL is not listed in /etc/shells"
  exit 1
fi

# --------------------------------------------------
# 2. Set zsh as default login shell
# --------------------------------------------------
USER_NAME="$(id -un)"
CURRENT_SHELL="$(getent passwd "$USER_NAME" | cut -d: -f7)"

if [[ "$CURRENT_SHELL" != "$TARGET_SHELL" ]]; then
  echo "🔁 Changing default shell to zsh"
  if ! chsh -s "$TARGET_SHELL" "$USER_NAME"; then
    echo "⚠️ chsh failed, falling back to usermod"
    sudo usermod -s "$TARGET_SHELL" "$USER_NAME"
  fi
else
  echo "✔ zsh already set as default shell"
fi

# Verify
FINAL_SHELL="$(getent passwd "$USER_NAME" | cut -d: -f7)"
if [[ "$FINAL_SHELL" != "$TARGET_SHELL" ]]; then
  echo "❌ Failed to set zsh as default shell"
  exit 1
fi

# --------------------------------------------------
# 3. Install Oh My Zsh (non-interactive)
# --------------------------------------------------
if [[ -d "$ZSH_DIR" ]]; then
  echo "✔ Oh My Zsh already installed"
else
  echo "➕ Installing Oh My Zsh"
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# --------------------------------------------------
# 4. Ensure .zshrc exists and is sane
# --------------------------------------------------
if [[ ! -f "$ZSHRC" ]]; then
  echo "➕ Creating .zshrc"
  cp "$ZSH_DIR/templates/zshrc.zsh-template" "$ZSHRC"
fi

# Ensure OMZ is sourced
if ! grep -q 'oh-my-zsh.sh' "$ZSHRC"; then
  cat >> "$ZSHRC" <<'EOF'

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh
EOF
fi

echo "✅ zsh + Oh My Zsh setup complete"
echo "ℹ️  FULL logout or reboot required"


