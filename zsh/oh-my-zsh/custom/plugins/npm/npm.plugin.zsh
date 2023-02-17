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

function yir() {
  [ -e yarn.lock ] && yarn ${1-install}
  [ -e package-lock.json ] && npm run ${1-install}
}


alias y='yir'
alias ys='yir start'
alias yt='yir test'
alias ysm='ENABLE_MIRAGE=true MSW_ENABLED=true VITE_ENABLE_MSW=true yir start'
alias ysl='API_HOST=http://localhost:8880/ yir start'
alias yte='yir test:ember'
alias yl='yir lint'
alias ytw='yir test:watch'
alias yb='yir build'
alias tw='npm run test-watch-chrome' 
alias cdep='gaa && gcmsg "Update dependencies" && git push'
alias plock='npm i && gaa && gcmsg "package lock" && git push'
alias replock='rm -rf node_modules && rm package-lock.json && npm i && gcam "Update package lock" && git push'



# todo: make separate lerna plugin
alias lb='npx lerna bootstrap'
alias lr='npx lerna run'
