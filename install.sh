#!/bin/bash

# Setup essential configuration of the unix system

# [CONFIG ITEMS]
# - bash shell
# - neovim editor
# - tmux multiplexer
# - pyenv

# Helper color
WHITE="\033[0;37m"
GREEN="\033[0;32m"
RED="\033[0;31m"
ORANGE="\033[0;33m"

# Dependent program of the installation
MAC_DEPENDENCIES=("brew" "nvim" "tmux" "curl" "git" "xcode-select")
LINUX_DEPENDENCIES=("nvim" "tmux" "curl" "git" "cmake" "clang")

# Where the configuration files live
DOTFILE_DIR="${HOME}/.dotfile"
NVIM_DIR="${HOME}/.config/nvim"
TMUX_DIR="${HOME}"

OS=$(uname | tr [:upper:] [:lower:])

# The following path will be determined later
BASH_PATH=""
ALTERNATE_BASH_PATH=""


# check all the dependencies is install or not
FLAG=0
echo -e "${ORANGE}[Check dependency]${WHITE}"
echo "----------------------------------------"
if [[ ${OS} = "darwin" ]]; then

    BASH_PATH="${HOME}/.bash_profile"
    ALTERNATE_BASH_PATH=".bashrc"

    for item in ${MAC_DEPENDENCIES[@]}; do
        type ${item} >/dev/null 2>&1
        if [[ $? -eq 0 ]]; then
            echo -e "${GREEN}${item} --- installed!"
        else
            echo -e "${RED}${item} --- not available!"
            FLAG=1
        fi
    done
else

    BASH_PATH="${HOME}/.bashrc"
    ALTERNATE_BASH_PATH=".bash_profile"

    for item in ${LINUX_DEPENDENCIES[@]}; do
        type ${item} >/dev/null 2>&1
        if [[ $? -eq 0 ]]; then
            echo -e "${GREEN}${item} --- installed!"
        else
            echo -e "${RED}${item} --- not available!"
            FLAG=1
        fi
    done
fi

[ ${FLAG} -eq 1 ] && { echo -e "${RED}Please install the essential programs above..."; exit 1; }

echo -e "${ORANGE}Installation Begin${WHITE}"
echo "----------------------------------------"

# check if the dotfile is cloned into the ~/.dotfile dir
[ ! -d ${DOTFILE_DIR} ] && { echo -e "${RED}Please clone git repo 'dotfile' to ${DOTFILE_DIR}...${WHITE}"; exit 1; }

# [Bash setting]
git clone https://github.com/Bash-it/bash-it.git "${HOME}/.bash-it"
"${HOME}/.bash-it/install.sh" --silent

# Export soft links
ln -s "${DOTFILE_DIR}/exports" "${HOME}/.exports"
ln -s "${DOTFILE_DIR}/aliases" "${HOME}/.aliases"

# append code that . bashrc from the bash_profile
echo -e "for file in ~/{${ALTERNATE_BASH_PATH},.exports,.aliases}; do\n   [ -r \${file} ] && [ -f \${file} ] && { . \${file}; }\ndone;\n" >> "${BASH_PATH}"

# Modify the theme in the file .bash_profile
sed -i 's/^export BASH_IT_THEME=.*/export BASH_IT_THEME="sexy"/' "${BASH_PATH}"

echo ""
echo -e "${GREEN}Bash setting complete!${WHITE}"
echo ""

# [Neovim setting]
mkdir -p "${NVIM_DIR}"
ln -s "${DOTFILE_DIR}/init.vim" "${NVIM_DIR}/init.vim"

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +silent +PlugInstall +qall

# [Powerline Font]
if [[ ${OS} = "darwin" ]]; then
    git clone https://github.com/powerline/fonts.git --depth=1
    cd font
    ./install.sh
    cd ..
    rm -rf font
else
    sudo apt-get install fonts-powerline
fi

echo ""
echo -e "${GRREN}Neovim setting complete!${WHITE}"
echo ""

# [Tmux Setting]
ln -s "${DOTFILE_DIR}/tmux.conf" "${TMUX_DIR}/.tmux.conf"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo ""
echo -e "${GREEN}Tmux setting complete!${WHITE}"
echo ""

# [pyenv & pyenv virtualenv setting]
if [[ ${OS} = "darwin" ]]; then
    brew install pyenv
else
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
fi

echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> "${BASH_PATH}"
. ${BASH_PATH}

echo 'eval "$(pyenv virtualenv-init -)"' >> "${BASH_PATH}"
. ${BASH_PATH}

echo ""
echo -e "${GREEN}pyenv and pyenv-virtualenv complete setting complete!${WHITE}"
echo ""

echo -e "${RED}Execute following cmd to complete the installation${WHITE}"
echo -e 'git clone https://github.com/pyenv/pyenv-virtualenv.git "$(pyenv root)/plugins/pyenv-virtualenv"'
