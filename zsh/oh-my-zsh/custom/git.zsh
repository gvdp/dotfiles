
alias grd="gf && grb origin/develop"
alias grm="gf && grb origin/main"
alias grid="gf && grbi origin/develop"
alias grim="gf && grbi origin/main"


function gprune() {
  echo "pruning with $(git_main_branch)"
  gbda && git remote prune origin && g trim
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

gcsc() {
  local msg=""
  local forced_type=""
  local type=""
  local scope=""

  # --- Parse args ---
  for arg in "$@"; do
    case $arg in
      --type=*)
        forced_type="${arg#*=}"
        ;;
      *)
        msg="$arg"
        ;;
    esac
  done

  if [[ -z "$msg" ]]; then
    echo "Usage: gcsc \"message\" [--type=chore]"
    return 1
  fi

  # --- Types list ---
  local types=("feat" "fix" "docs" "style" "refactor" "test" "chore" "ci" "perf")

  # --- Step 1: Determine commit type ---
  if [[ -n "$forced_type" ]]; then
    type="$forced_type"
  else
    echo "Select commit type:"
    select t in "${types[@]}"; do
      [[ -n "$t" ]] && type="$t" && break
      echo "Invalid selection."
    done
  fi

  # --- Step 2: Determine scope (package) ---
  # Case A: User is inside packages/<pkg>
  local current_dir="$(pwd)"
  if [[ "$current_dir" == *"/packages/"* ]]; then
    # extract the package folder name
    scope="${current_dir##*/packages/}"
    scope="${scope%%/*}"

  else
    # Case B: Not inside a package → list all packages
    if [[ ! -d "packages" ]]; then
      echo "Error: No packages/ directory found."
      return 1
    fi

    local scopes=("${(@f)$(ls -1 packages)}")

    echo "Select package scope:"
    select s in "${scopes[@]}"; do
      [[ -n "$s" ]] && scope="$s" && break
      echo "Invalid selection."
    done
  fi

  # --- Step 3: Final commit ---
  local final_msg="${type}(${scope}): ${msg}"
  echo "Committing: \"$final_msg\""

  git commit -m "$final_msg"
}
