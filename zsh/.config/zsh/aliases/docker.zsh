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
alias dspr='docker system prune '
alias drpa='docker exec -it $WEB_CONTAINER /bin/bash -c "rake assets:precompile; exit" '
alias drc='docker exec -it $WEB_CONTAINER /bin/bash -c "rails c" '

