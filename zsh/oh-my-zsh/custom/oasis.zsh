# You can put files here to add functionality separated per file, which
# will be ignored by git.
# Files on the custom/ directory will be automatically loaded by the init
# script, in alphabetical order.

# For example: add yourself some shortcuts to projects you often work on.
#
# brainstormr=~/Projects/development/planetargon/brainstormr
# cd $brainstormr
#


function oia() {
 cd ~/abs-shop/code/apps/outbound-invoice-app
}


alias ca='cd ~/abs-shop/code/apps/contract-app'
alias apa='cd ~/abs-shop/code/apps/asset-purchase-app'
alias asa='cd ~/abs-shop/code/apps/asset-app'

function ssa() {
  cd ~/abs-shop/code/apps/service-subscription-app
}

function sss() {
  cd ~/abs-shop/code/services/service-subscription-service
}

function pma() {
  cd ~/abs-shop/code/apps/payment-management-app
}

function iia() {
  cd ~/abs-shop/code/apps/inbound-invoice-app
}

alias cm='cd ~/abs-shop/code/common/alphabet-cas-module'
alias ft='cd ~/abs-shop/code/common/frontend-toolbox'

alias cms='cd ~/abs-shop/code/services/contract-management-service'
alias ams='cd ~/abs-shop/code/services/asset-management-service'
alias bppcs='cd ~/abs-shop/code/services/business-partner-payment-configuration-service'
alias ois='cd ~/abs-shop/code/services/outbound-invoice-service'
alias iis='cd ~/abs-shop/code/services/inbound-invoice-service'
alias abi='cd ~/abs-shop/code/services/ace-to-bi-service'

alias serv='cd ~/abs-shop/code/services'
alias envs='cd ~/abs-shop/code/environments'

alias ds='cd ~/abs-shop/code/common/design-system'
alias tt='cd ~/abs-shop/code/common/testing-toolbox'



alias kdev2='k9s --context dev-k8s --namespace dev-2'
alias kdev4='k9s --context dev-k8s --namespace dev-4'

alias kacc3='k9s --context acc-k8s --namespace acc-3'
alias kacc2='k9s --context acc-k8s --namespace acc-2'
alias kacc1='k9s --context acc-k8s --namespace acc-1'
alias ksit1='k9s --context acc-k8s --namespace sit-1'

alias init_dblab='sh ~/dotfiles/oasis-script/init_dblab.zsh'
alias dbclone='dblab clone create --username glenn --password glenn --id=bynx-clone'

function add-to-dev() (
  branch=$(git branch --show-current)
  repo=$(git remote get-url origin)
  service=$(echo $repo | cut -d / -f 5 | cut -d . -f 1)

  echo "adding branch $branch of $service to dev $1"

  cd ~/abs-shop/code/environments/ace-cloud-dev
  gco master
  git pull
  gsed -i "/${service}/s,ref=.*,ref=${branch},g" "dev-$1/kustomization.yaml"
  gcam "Update ${service} on dev-$1"
  gp
)

