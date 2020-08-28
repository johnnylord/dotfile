#!/bin/zsh

# Virtualenv prompt
export venv=""

function virtualenv_info() {
    which pyenv 2>&1 1>/dev/null
    if [[ $(echo $?) ]]; then
        export venv=$(pyenv version | sed 's/ .*//g')
    fi
}

autoload -U add-zsh-hook
add-zsh-hook precmd virtualenv_info

PROMPT=$'%{$fg_bold[cyan]%}(${venv}) %(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )'
PROMPT+=' %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
