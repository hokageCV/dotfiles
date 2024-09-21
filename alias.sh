alias c='clear'
alias tree='cmd //c tree' # windows command in git bash

# alias sk='cd  ~/dev/ssh_keys'
# alias gr='sk && eval $(ssh-agent -s) && ssh-add ./gh && cd -'
# alias zshopen='vi ~/.zshrc && source ~/.zshrc'
# alias scpt='cd ~/scripts_makerble && ./execute_makerble_scripts.sh && mak '

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# git
alias g='git '

alias gbd='git branch -d '
alias gbdd='git branch -D '
alias gbm='git branch -m '
alias gbl='git branch --list '

alias gcm='git commit -m '
alias gca='git commit --amend '
alias gcan='git commit --amend --no-edit '

alias gc='git checkout '
alias gc-='git checkout - '
alias gcb='git checkout -b '
alias gp='git checkout pre-production'
alias gd='git checkout develop'

alias ga='git add '
alias gpo='git push origin '
alias gpu='git push '
alias gpl='git pull '
alias gpuf='git push --force-with-lease '

alias gs='git stash push '
alias gsm='git stash push -m '
alias gsp='git stash pop '
alias gsa='git stash apply '
alias gsl='git stash list '
alias gsu='git stash push --include-untracked '
alias gsum='git stash push --include-untracked -m '

alias gl='git log '
alias glp='git log -p '
alias glo="git log  --oneline --format='%C(auto)%h %C(blue)%ad %C(green)%an  %C(auto)%s' --date=format:'%d-%m-%y %H:%M'  "
alias glon="git log  --oneline --no-merges --format='%C(auto)%h %C(blue)%ad %C(green)%an  %C(auto)%s' --date=format:'%d-%m-%y %H:%M'  "
alias glpw='git log -p --color-words '

alias grfl='git reflog '
alias gsts='git status '
alias grb='git rebase '

# npm
alias nr='npm run '
alias nd='npm run dev'
alias ns='npm run start'

# hugo
alias hs='hugo server'

# rails
alias rs='rails server '
alias rc='rails console '
alias rdm='rails db:migrate '

# docker
WEB_CONTAINER="docker_rails-web-1"
DB="docker_rails-postgres-1"
URL_SHORTNER_CONTAINER="url-shortner-web-1"
#WEB_CONTAINER="makerble-web-1"
#DB="makerble-postgres-1"

alias d='docker '
alias du='clear && docker compose up '
alias ds='docker compose stop'
alias dcb='docker compose build'
alias dcd='docker compose down'
alias dcdb='docker compose down && docker compose build '
alias dcdbu='docker compose down && docker compose build && docker compose up  '
alias dps='docker ps'
alias da="clear && docker attach $WEB_CONTAINER "
alias de="docker exec -it $WEB_CONTAINER /bin/bash"
alias depp='docker exec -it $DB /bin/bash -c "psql -U postgres -d makerble_production -x"'
alias desp='docker exec -it $DB /bin/bash -c "psql -U postgres -d makerble_staging -x"'
alias dep='docker exec -it $DB /bin/bash -c "psql -U postgres -d makerble -x"'
alias dr='docker compose restart web'
alias dra='docker compose restart web && da '

alias dau="clear && docker attach $URL_SHORTNER_CONTAINER "

# rails
alias drpa='docker exec -it $WEB_CONTAINER /bin/bash -c "rake assets:precompile; exit" '
alias drc='docker exec -it $WEB_CONTAINER /bin/bash -c "rails c" '
