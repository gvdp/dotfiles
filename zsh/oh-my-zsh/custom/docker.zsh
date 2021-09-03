

alias dupd='docker-compose down -v & docker-compose up -d'
function dw() {
  watch -n 1 'docker ps --format "table {{.Names}}\t{{.Status}}" -a'
}
