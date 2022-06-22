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

alias nr='npm run'
alias ns='npm run start'
alias ys='yarn start'
alias ysm='ENABLE_MIRAGE=true yarn start'
alias yt='yarn test'
alias yte='yarn test:ember'
alias yl='yarn lint'
alias ytw='yarn test:watch'
alias tw='npm run test-watch-chrome' 
alias cdep='gaa && gcmsg "Update dependencies" && git push'
alias plock='npm i && gaa && gcmsg "package lock" && git push'
alias replock='rm -rf node_modules && rm package-lock.json && npm i && gcam "Update package lock" && git push'
