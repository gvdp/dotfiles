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
   npm i --save @alphabet/core-components@latest --save-exact
   git reset HEAD
   git add package.json
   git add package-lock.json
   gcmsg "Update core components version"
   gp
}

function cmod() {
  npm i --save @alphabet/cas-module@0.0.0-$1
}
 
alias tw='npm run test-watch-chrome' 
alias cdep='gaa && gcmsg "Update dependencies" && git push'
alias plock='npm i && gaa && gcmsg "package lock" && git push'