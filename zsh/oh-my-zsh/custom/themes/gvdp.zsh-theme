# Put your custom themes in this folder.
# Example:

autoload -U add-zsh-hook
autoload -Uz vcs_info

zstyle ':vcs_info:*' actionformats \
       '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats '%F{2}%s%F{7}:%F{2}(%F{1}%b%F{2})%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' enable git

add-zsh-hook precmd prompt_vcs
add-zsh-hook precmd prompt_node

prompt_vcs () {
    vcs_info

    if [ "${vcs_info_msg_0_}" = "" ]; then
        dir_status="%F{2}→%f"
    elif [[ $(git diff --cached --name-status 2>/dev/null ) != "" ]]; then
        dir_status="%F{1}▶%f"
    elif [[ $(git diff --name-status 2>/dev/null ) != "" ]]; then
        dir_status="%F{3}▶%f"
    else
        dir_status="%F{2}▶%f"
    fi
}

prompt_node() {
	if [ -f package.json ]; then
# 			colors are not really nice here
# 			node_version="%K{green}%F{black} "$'\Ue0b0'" %f "$'\Ue718'" $(node --version) %k %F{green} "$'\Ue0b0'" %f"
			node_version=" %F{green}"$'\Ue718'" $(node --version)%f "
	else
			node_version=" "
	fi
}

function {
    if [[ -n "$SSH_CLIENT" ]]; then
        PROMPT_HOST=" ($HOST)"
    else
        PROMPT_HOST=''
    fi
}

local ret_status="%(?:%{$fg_bold[green]%}▷:%{$fg_bold[red]%}▷ %s%?)"


PROMPT='${ret_status} %{$fg_bold[yellow]%}%2~${node_version}${vcs_info_msg_0_}${dir_status} %{$reset_color%} '
# RPROMPT='${node_version}'
