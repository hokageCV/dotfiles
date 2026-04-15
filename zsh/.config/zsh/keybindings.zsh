# enable emacs mode (disable vi mode)
# to get the single line cursor
bindkey -e

# open buffer line in editor with ctrl+x, ctrl+e
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

