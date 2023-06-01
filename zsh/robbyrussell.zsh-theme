#!/bin/zsh

# Virtualenv prompt
venv=""
host=""

function virtualenv_info() {
    which pyenv 2>&1 1>/dev/null
    if [[ $(echo $?) ]]; then
        venv=$(pyenv version | sed 's/ .*//g')
    fi
}

function hostname_info() {
    string=$(hostname -I)
    host=(`echo $string | sed 's/\ /\n/g'`)
    host=${host[1]}
}

function nvpowertool_info() {
    systemctl status nvpowertool.service 1>/dev/null 2>/dev/null
    if [ $? -eq 0 ]; then
	nvpowertool="[nvpowertool:active] "
    else
        nvpowertool=""
    fi
}

autoload -U add-zsh-hook
add-zsh-hook precmd virtualenv_info
add-zsh-hook precmd hostname_info
add-zsh-hook precmd nvpowertool_info

PROMPT=$'%{$fg_bold[red]%}[${host}] %{$fg_bold[yellow]%}${nvpowertool}%{$fg_bold[cyan]%}(${venv})'
PROMPT+=' %{$fg[green]%}%c%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
