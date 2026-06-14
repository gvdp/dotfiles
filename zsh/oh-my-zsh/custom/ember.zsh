alias egcc="ember generate component-class"
alias egat="ember generate acceptance-test"
alias e="ember"
alias eg="ember generate"

egc() {
  # $1 represents the name of the component you pass as an argument
  ember generate component "$1"
  ember generate sg-component "$1"
}
