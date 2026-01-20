alias g='git '

alias gr='eval $(ssh-agent -s) && ssh-add ~/.ssh/hokage'

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
alias glop='git log --oneline --decorate --format='\''%C(auto)%h %C(yellow)%p %C(red)%d %C(blue)%ad %C(green)%an %C(auto)%s'\'' --date=format:'\''%d-%m-%y %H:%M'\'''
alias glp-='glp $(fc -ln -1 | awk "{print \$2}")' # for zsh. use this after glo. this gets the file used in glo and uses in glp
alias glpw='git log -p --color-words '
alias glod="git log --format='%C(auto)%h %C(blue)%ad %C(green)%an%n%C(auto)%B' --date=format:'%d-%m-%y %H:%M'" # show commit description if any

alias gupsw='git update-index --skip-worktree '
alias gupnsw='git update-index --no-skip-worktree '

alias grfl='git reflog '
alias gsts='git status '
alias grb='git rebase '
alias grs='git restore '
alias grs.='git restore . '

alias lg='lazygit '
alias gh-create='gh repo create --private --source=. --remote=origin && git push -u --all && gh browse'

# display last author's number of commits. Useful for getting the count before interactive rebase
alias mycommits="git log --pretty=format:'%an' | awk 'NR==1 {author=\$0} \$0==author {count++} \$0!=author {exit} END {print count}'"

