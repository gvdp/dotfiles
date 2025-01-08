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

function y() {
  for dir in "." ".." "../.."; do
    [ -e "$dir/yarn.lock" ] && if [ -z "$1" ]; then yarn install; else yarn run $1; fi && return
    [ -e "$dir/package-lock.json" ] && if [ -z "$1" ]; then npm install; else npm run $1; fi && return
    [ -e "$dir/pnpm-lock.yaml" ] && if [ -z "$1" ]; then pnpm install; else pnpm $1; fi && return
  done
}

function yadd() {
  [ -e yarn.lock ] && yarn add --dev --exact $1  && return
  [ -e pnpm-lock.yaml ] && pnpm add $1 --save-dev --save-exact && return
}

function yad() {
  [ -e yarn.lock ] && yarn add --exact $1  && return
  [ -e pnpm-lock.yaml ] && pnpm add $1 --save --save-exact && return
}

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
alias ysm='ENABLE_MIRAGE=true MSW_ENABLED=true VITE_ENABLE_MSW=true y start'
alias ysl='API_HOST=http://localhost:8880/ y start'
alias yte='y test:ember'
# alias yl='y lint'
alias yll='ylf && yl'
alias ylf='y lint:format:fix'
alias ytw='y test:watch'
alias yb='y build'
alias tw='npm run test-watch-chrome' 
alias cdep='gaa && gcmsg "Update dependencies" && git push'
alias plock='npm i && gaa && gcmsg "package lock" && git push'
alias replock='rm -rf node_modules && rm package-lock.json && npm i && gcam "Update package lock" && git push'



# todo: make separate lerna plugin
alias lb='npx lerna bootstrap'
alias lr='npx lerna run'
