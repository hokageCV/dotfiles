# Ensure PATH entries are unique (zsh-native)
typeset -U path

if command -v rbenv >/dev/null 2>&1; then
  [[ -d "$HOME/.rbenv/bin" ]] && path=("$HOME/.rbenv/bin" $path)
  eval "$(rbenv init -)"
fi

# pnpm
export PNPM_HOME="/home/hokage/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end

[[ -d "$HOME/.cargo/bin" ]] && path=("$HOME/.cargo/bin" $path)
[[ -d "$HOME/.opencode/bin" ]] && path=("$HOME/.opencode/bin" $path)
[[ -d "$HOME/.local/bin" ]] && path=("$HOME/.local/bin" $path)
[[ -d "$HOME/.npm-global/bin" ]] && path=("$HOME/.npm-global/bin" $path)

