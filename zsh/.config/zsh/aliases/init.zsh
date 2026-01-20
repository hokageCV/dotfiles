alias_files=(
  navigation.zsh
  git.zsh
  docker.zsh
  rails.zsh
  misc.zsh
)

for file in "${alias_files[@]}"; do
  if [[ -f "${ZDOTDIR}/aliases/$file" ]]; then
    source "${ZDOTDIR}/aliases/$file"
  fi
done


# named directories
hash -d code=~/hokage/code

# global alias
alias -g NE='2>/dev/null'
