
alias grd="gf && grb origin/develop"
alias grid="gf && grbi origin/develop"


function gprune() {
  echo "pruning with $(git_main_branch)"
  gbda && git remote prune origin
}
alias gmm="git fetch && git merge origin/$(git_main_branch) --no-edit && git push"
alias gcc="gaa && git commit --no-edit && git push"

alias gcd="gf && gco develop && gl && gprune && yarn"

alias gcm="gf && gco main && gl && gprune"

function gfc() {
  gf
  git switch $(git branch -a | fzf | tr -d '[ ]' | sed 's/remotes\/origin\///')
}

function gign() {
  echo $1 >> .gitignore
}


## appy git diff from boilerplate
## git remote add boilerplate git@git.bagaar.be:shelf/front-end/ember/ember-project-boilerplate.git
## git remote update
## git diff boilerplate remotes/boilerplate/main --diff-filter=d | git apply

