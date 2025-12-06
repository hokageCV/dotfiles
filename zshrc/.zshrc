export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

if [[ -x "$HOME/scripts/start-ssh-agent.sh" ]]; then
	"$HOME/scripts/start-ssh-agent.sh"
fi

if [ -f "$HOME/.config/zsh/alias.sh" ]; then
    source "$HOME/.config/zsh/alias.sh" 
fi


# pnpm
export PNPM_HOME="/home/hokage/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
export MOZ_ENABLE_WAYLAND=1
export OZONE_PLATFORM=wayland
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.cargo/bin:$PATH"
