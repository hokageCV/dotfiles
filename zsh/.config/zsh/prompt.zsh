setopt PROMPT_SUBST

autoload -Uz vcs_info
zstyle ':vcs_info:git:*' formats '%b'

precmd() {
  vcs_info
}

git_prompt() {
  [[ -z "$vcs_info_msg_0_" ]] && return
  echo "%F{#3a8fd8}(%f%B%F{#ee7b4f}${vcs_info_msg_0_}%b%f%F{#3a8fd8})%f"
}

PROMPT='%F{#49d6e9}➜ %f%F{#5fd7ff}%1~%f $(git_prompt) '

