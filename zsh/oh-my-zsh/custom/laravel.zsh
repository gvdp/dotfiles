## Docker
alias pr="docker-compose run --rm php"         # run command in php container

## Composer
alias c="composer"
alias cgd="composer generate-docs"
alias pri="pr composer install"                # install dependencies (via Docker)

## Testing
alias pft="pr composer test"                   # run test suite (via Docker)
alias ptt="pr composer test"                   # run test suite (via Docker)
alias ctf="c test -- --filter"                 # run single test by name: ctf <name>
alias ptf="pr composer test -- --filter"       # run single test by name (via Docker): ptf <name>

## Linting & static analysis
alias plp="c pint -- --dirty && c phpstan"     # pint (dirty files) + phpstan
alias pla="plp && c test"                      # full pipeline: lint + phpstan + tests

## Artisan
alias pa="php artisan"
alias pra="pr php artisan"                     # artisan (via Docker)
alias prr="pr php artisan migrate:fresh --seed" # fresh migrate + seed (via Docker)
alias prm="pr php artisan migrate"             # migrate (via Docker)
alias pds="pr php artisan db:seed"             # seed (via Docker)
alias pos="pa octane:frankenphp --watch"       # start Octane with FrankenPHP

## Make
alias m="make"
alias ml="make lint-fix && make phpstan"
alias mt="make test"

function phelp() {
  local file="$ZSH_CUSTOM/laravel.zsh"
  local section=""

  while IFS= read -r line; do
    if [[ $line =~ ^##[[:space:]]+(.+) ]]; then
      [[ -n $section ]] && echo ""
      echo "  ${match[1]}"
      section="${match[1]}"
    elif [[ $line =~ ^alias[[:space:]]+([^=]+)=.*#[[:space:]]+(.+) ]]; then
      printf "    %-6s  %s\n" "${match[1]}" "${match[2]}"
    fi
  done < "$file"
}
