alias gprune='git branch --merged master | grep -v '"'"'^[ *]*master$'"'"' | xargs git branch -d && git remote prune origin'

# todo: make this main / master branch aware
alias gmm="git fetch && git merge origin/master --no-edit && git push"
alias gcc="gaa && git commit --no-edit && git push"

function gfc() {
  gf
  git switch $(git branch -a | fzf | tr -d '[ ]' | sed 's/remotes\/origin\///')
}
