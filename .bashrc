export HISTTIMEFORMAT='%F %T '
export HISTIGNORE="ls*:cd*:pwd*:exit*:history*" # ':' is OR here
export HISTSIZE=10000000
export HISTCONTROL=ignoredups:erasedups
export LESS='-R'


if [ -f ~/alias.sh ]; then
  source ~/alias.sh
fi
