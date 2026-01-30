# Ensure PATH entries are unique (zsh-native)
typeset -U path

if command -v rbenv >/dev/null 2>&1; then
  [[ -d "$HOME/.rbenv/bin" ]] && path=("$HOME/.rbenv/bin" $path)
  eval "$(rbenv init -)"
fi

[[ -d "$HOME/.cargo/bin" ]]        && path=("$HOME/.cargo/bin" $path)
[[ -d "$HOME/.opencode/bin" ]]     && path=("$HOME/.opencode/bin" $path)
[[ -d "$HOME/.local/share/pnpm" ]] && path=("$HOME/.local/share/pnpm" $path)

