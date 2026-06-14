# Add your own custom plugins in the custom/plugins directory. Plugins placed
# here will override ones with the same name in the main plugins directory.

  
function remf() {
  fd .spec.ts$ | xargs gsed -i s/fdescribe/describe/
  fd .spec.ts$ | xargs gsed -i s/fit/it/
}

function nt() {
		echo "$1"
  if [ -n "$1" ]
  then 
    npm run test:$1
  else
    npm run test
  fi
}
# Helper: search for lockfiles upward
_find_pm() {
  for dir in "." ".." "../.." "../../../.."; do
    [ -e "$dir/yarn.lock" ] && echo "yarn" && return
    [ -e "$dir/package-lock.json" ] && echo "npm" && return
    [ -e "$dir/pnpm-lock.yaml" ] && echo "pnpm" && return
  done
  echo ""  # none found
}

# y command: run or install using closest manager
function y() {
  pm=$(_find_pm)

  case "$pm" in
    yarn)
      [ -z "$1" ] && yarn install || yarn run "$1"
      ;;
    npm)
      [ -z "$1" ] && npm install || npm run "$1"
      ;;
    pnpm)
      [ -z "$1" ] && pnpm install || pnpm "$1"
      ;;
    *)
      echo "No lockfile found."
      ;;
  esac
}

# yadd → add dev dependency using correct manager
function yadd() {
  pm=$(_find_pm)

  case "$pm" in
    yarn)
      yarn add --dev --exact "$@"
      ;;
    npm)
      npm install --save-dev --save-exact "$@"
      ;;
    pnpm)
      pnpm add "$@" --save-dev --save-exact
      ;;
    *)
      echo "No lockfile found."
      ;;
  esac
}

# yad → add regular dependency using correct manager
function yad() {
  pm=$(_find_pm)

  case "$pm" in
    yarn)
      yarn add --exact "$1"
      ;;
    npm)
      npm install --save-exact "$1"
      ;;
    pnpm)
      pnpm add "$1" --save --save-exact
      ;;
    *)
      echo "No lockfile found."
      ;;
  esac
}
# function y() {
#   for dir in "." ".." "../.."; do
#     [ -e "$dir/yarn.lock" ] && if [ -z "$1" ]; then yarn install; else yarn run $1; fi && return
#     [ -e "$dir/package-lock.json" ] && if [ -z "$1" ]; then npm install; else npm run $1; fi && return
#     [ -e "$dir/pnpm-lock.yaml" ] && if [ -z "$1" ]; then pnpm install; else pnpm $1; fi && return
#   done
# }
#
# function yadd() {
#   [ -e yarn.lock ] && yarn add --dev --exact "$@"  && return
#   [ -e pnpm-lock.yaml ] && pnpm add "$@" --save-dev --save-exact && return
# }
#
# function yad() {
#   [ -e yarn.lock ] && yarn add --exact $1  && return
#   [ -e pnpm-lock.yaml ] && pnpm add $1 --save --save-exact && return
# }
#
function yl() {
  if [ -z "$1" ];
  then 
    y lint
    return
  else
    y lint:$1
  fi
} 

alias ys='y start'
alias yt='y test'
alias ysm='ENABLE_MIRAGE=true MSW_ENABLED=true VITE_MSW_ENABLED=true VITE_ENABLE_MSW=true y start'
alias ysl='API_HOST=http://localhost:8880/ y start'
alias yte='y test:ember'
# alias yl='y lint'
alias yll='ylf && yl'
alias ylf='y lint:format:fix'
alias llf='lr lint:format:fix'
alias ytw='y test:watch'
alias yb='y build'
alias tw='npm run test-watch-chrome' 
alias cdep='gaa && gcmsg "Update dependencies" && git push'
alias plock='npm i && gaa && gcmsg "package lock" && git push'
alias replock='rm -rf node_modules && rm package-lock.json && npm i && gcam "Update package lock" && git push'



# todo: make separate lerna plugin
alias lb='npx lerna bootstrap'
alias lr='npx lerna run'
