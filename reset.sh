#!/bin/bash

# Reset the following software to its default state
# - bash shell
# - neovim editor
# - tmux multiplexer
# - pyenv

# Helper color
WHITE="\033[0;37m"
GREEN="\033[0;32m"
RED="\033[0;31m"
ORANGE="\033[0;33m"

# Where the configuration files live
DOTFILE_DIR="${HOME}/.dotfile"
NVIM_DIR="${HOME}/.config/nvim"
TMUX_DIR="${HOME}"

OS=$(uname | tr [:upper:] [:lower:])

# The following path will be determined later
BASH_PATH=""
ALTERNATE_BASH_PATH=""

if [[ ${OS} = "darwin" ]]; then
    BASH_PATH="${HOME}/.bash_profile"
    ALTERNATE_BASH_PATH=".bashrc"
else
    BASH_PATH="${HOME}/.bashrc"
    ALTERNATE_BASH_PATH=".bash_profile"
fi

# [Reset Bash shell]
rm -rf "${HOME}/.bash-it"
rm -rf "${HOME}/.exports"
rm -rf "${HOME}/.aliases"
rm -rf "${BASH_PATH}"
rm -rf "${ALTERNATE_BASH_PATH}"

if [[ -f "${BASH_PATH}.bak" ]]; then
    mv "${BASH_PATH}.bak" "${BASH_PATH}"
fi

if [[ -f "${ALTERNATE_BASH_PATH}.bak" ]]; then
    mv "${ALTERNATE_BASH_PATH}.bak" "${ALTERNATE_BASH_PATH}"
fi

echo ""
echo -e "${GREEN}Bash resetting complete!${WHITE}"
echo ""

# [Reset neovim]
rm -rf "${NVIM_DIR}"

echo ""
echo -e "${GRREN}Neovim resetting complete!${WHITE}"
echo ""

# [Reset tmux]
rm -rf "${TMUX_DIR}/.tmux.conf"
rm -rf ~/.tmux/plugins/tpm

echo ""
echo -e "${GRREN}Tmux resetting complete!${WHITE}"
echo ""

# [pyenv & pyenv virtualenv setting]
if [[ ${OS} = "darwin" ]]; then
    brew uninstall pyenv
else
    rm -rf ~/.pyenv
fi

echo ""
echo -e "${GRREN}pyenv & pyenv-virtualenv resetting complete!${WHITE}"
echo ""
