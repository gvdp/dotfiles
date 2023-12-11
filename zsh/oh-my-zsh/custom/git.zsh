
alias grd="gf && grb origin/develop"
alias grm="gf && grb origin/main"
alias grid="gf && grbi origin/develop"
alias grim="gf && grbi origin/main"


function gprune() {
  echo "pruning with $(git_main_branch)"
  # todo: maybe only keep git trim if that does enough
  git trim && gbda && git remote prune origin
}

alias gmm="git fetch && git merge origin/$(git_main_branch) --no-edit && git push"
alias gcc="gaa && git commit --no-edit && git push"

# todo: do composer install here if its a laravel project
alias gcd="gf && gco develop && gl && gprune && y"
alias gcm="gf && gco main && gl && gprune && y"


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

