# Add your own custom plugins in the custom/plugins directory. Plugins placed
# here will override ones with the same name in the main plugins directory.

function nps() {
  export AZURE=true
  export SERVER=$1
  export EXTERNALREALM=false
  npm run start
}

function npsext() {
  export AZURE=true
  export SERVER=$1
  export EXTERNALREALM=true
  npm run start
}

function itt() {
  npm i --save testing-toolbox@0.0.0-$1
}

function icas() {
  npm i --save @alphabet/cas-module@0.0.0-$1
}

function icore() {
  npm i --save @alphabet/core-components@0.0.0-$1
}

function ift() {
  npm i --save frontend-toolbox@0.0.0-$1
}


function uptt() {
   npm i --save testing-toolbox@latest --save-exact
   git reset HEAD
   git add package.json
   git add package-lock.json
   gcmsg "Update testing toolbox version"
   gp
}


function upcas() {
   npm i --save @alphabet/cas-module@latest --save-exact
   git reset HEAD
   git add package.json
   git add package-lock.json
   gcmsg "Update cas module version"
   gp
}

function upft() {
   npm i --save frontend-toolbox@latest --save-exact
   git reset HEAD
   git add package.json
   git add package-lock.json
   gcmsg "Update frontend toolbox version"
   gp
}


function upcore() {
   npm i --save @alphabet/core-components@">0.0.0" --save-exact
   git reset HEAD
   git add package.json
   git add package-lock.json
   gcmsg "Update core components version"
   gp
}

function addCasTo() (
  branch=$(git branch --show-current)
  $1
  gco $branch
  icas $branch
  gcam "Update cas module" && gp
)

function remf() {
  fd .spec.ts$ | xargs gsed -i s/fdescribe/describe/
  fd .spec.ts$ | xargs gsed -i s/fit/it/
}

# wont work until tt is on Tekton because on Jenkins you need to specify the exact build number
#function addTTTo() (
#  branch=$(git branch --show-current)
#  $1
#  g stash
#  gco $branch
#  itt $branch
#  gcam "Update testing toolbox" && gp
#  gstp
#)

function cmod() {
  npm i --save @alphabet/cas-module@0.0.0-$1
}
 
alias tw='npm run test-watch-chrome' 
alias cdep='gaa && gcmsg "Update dependencies" && git push'
alias plock='npm i && gaa && gcmsg "package lock" && git push'
alias replock='rm -rf node_modules && rm package-lock.json && npm i && gcam "Update package lock" && git push'