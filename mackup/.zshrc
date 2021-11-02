# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:/Users/gvdp/Library/Python/3.7/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/gvdp/.oh-my-zsh

# source ~/.zshenv

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="gvdp"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="mm/dd/yyyy"


# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  npm
  alias-tips
  bd
)

# todo: not sure if this is really what I want
plugins+=(careful_rm)

source $ZSH/oh-my-zsh.sh


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# add color to man pages
export MANROFFOPT='-c'
export LESS_TERMCAP_mb=$(tput bold; tput setaf 2)
export LESS_TERMCAP_md=$(tput bold; tput setaf 6)
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4)
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7)
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)


# If a local zshrc exists, source it
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

if [[ -a ~/.localrc ]]; then
    source ~/.localrc
fi



# use nvim, but don't make me think about it
[[ -n "$(command -v nvim)" ]] && alias vim="nvim"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
    colorflag="--color"
else # macOS `ls`
    colorflag="-G"
fi

alias l="ls -lah ${colorflag}"
alias la="ls -AF ${colorflag}"
alias ll="ls -lFh ${colorflag}"
alias lld="ls -l | grep ^d"

# Helpers
alias grep='grep --color=auto'
alias df='df -h' # disk free, in Gigabytes, not bytes
alias du='du -h -c' # calculate disk usage for a folder


# tmux aliases
alias ta='tmux attach'
alias tls='tmux ls'
alias tat='tmux attach -t'
alias tns='tmux new-session -s'


if [[ -d ~/abs-shop ]]; then

    # OASIS Variables
    export OASIS_HOME=${HOME}/abs-shop
    export HTTP_PROXY=http://proxy.muc:8080
    export HTTPS_PROXY=http://proxy.muc:8080
    export ALL_PROXY=http://proxy.muc:8080
    export NO_PROXY=.bmwgroup.net,localhost,.muc,192.168.99.100
    export PATH="$PATH:$OASIS_HOME"

    alias idea='~/abs-shop/tools/idea'
    alias node12='export PATH="/usr/local/opt/node@12/bin:$PATH"'

else
    alias idea="~/.idea/idea"
fi

if alias node12 &>/dev/null; then
   node12;
fi


alias k="kubectl"

function zsh_plugin() {
  cd $DOTFILES/zsh/oh-my-zsh/custom/plugins
  git submodule add $1
  . $DOTFILES/install.sh link
  # todo: also make this add to the plugin array here in the .zshrc
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


export CLOUDSDK_PYTHON=/usr/bin/python3

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/gvdp/code/tools/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/gvdp/code/tools/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/gvdp/code/tools/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/gvdp/code/tools/google-cloud-sdk/completion.zsh.inc'; fi

#export PATH="/usr/local/opt/ruby/bin:$PATH"
#export PATH="/usr/local/lib/ruby/gems/3.0.0/bin:$PATH"
#export PATH="/usr/local/opt/ruby/bin:$PATH"

# todo: should be variable per machine
export CODE_FOLDER="~/abs-shop/code/"

alias dot="cd $DOTFILES"
alias resource="source ~/.zshrc"
alias code="cd $CODE_FOLDER"

#  - [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 50% --border'
export FZF_DEFAULT_COMMAND='fd -I --type f'

alias fzp="fzf --preview 'cat {}'"

alias of='vi $(fzf)'



alias crep='cd $(fd -d 2 --type d . $CODE_FOLDER | fzf)'

alias gal='alias | grep'


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$/.sdkman"
[[ -s "$/.sdkman/bin/sdkman-init.sh" ]] && source "$/.sdkman/bin/sdkman-init.sh"