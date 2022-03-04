
alias grd="gf && grb origin/develop"


function gprune() {
  echo "pruning with $(git_main_branch)"
  gbda && git remote prune origin
}
alias gmm="git fetch && git merge origin/$(git_main_branch) --no-edit && git push"
alias gcc="gaa && git commit --no-edit && git push"

function gfc() {
  gf
  git switch $(git branch -a | fzf | tr -d '[ ]' | sed 's/remotes\/origin\///')
}

function gign() {
  echo $1 >> .gitignore
}
