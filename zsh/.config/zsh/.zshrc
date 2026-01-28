# Antidote
source "${ZDOTDIR}/antidote/antidote.zsh"
antidote load "${ZDOTDIR}/plugins.txt"

# =====================

if [[ -x "$HOME/scripts/start-ssh-agent.sh" ]]; then
	"$HOME/scripts/start-ssh-agent.sh"
fi

# ===================

source "${ZDOTDIR}/prompt.zsh"
source "${ZDOTDIR}/history.zsh"
source "${ZDOTDIR}/keybindings.zsh"
source "${ZDOTDIR}/aliases/init.zsh"

# ===================

setopt AUTO_CD

autoload -Uz compinit
compinit

zstyle ':completion:*' matcher-list \
  'm:{a-zA-Z}={A-Za-z}' \
  'r:|=*' \
  'l:|=*'

export EDITOR="nvim"
export VISUAL="nvim"

# ===================

# pnpm
export PNPM_HOME="/home/hokage/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export MOZ_ENABLE_WAYLAND=1
export OZONE_PLATFORM=wayland

if command -v rbenv >/dev/null 2>&1; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

export PATH="$HOME/.cargo/bin:$PATH"

