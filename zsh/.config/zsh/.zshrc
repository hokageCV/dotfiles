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
source "${ZDOTDIR}/autocomplete.zsh"
source "${ZDOTDIR}/aliases/init.zsh"
source "${ZDOTDIR}/variables.zsh"

source "${ZDOTDIR}/path.zsh"

