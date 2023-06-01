#!/bin/bash

if [ $USER != "root" ]; then
    echo "Please execute setup.sh with sudo permission"
    exit 1
fi

if [ $# -ne 1 ]; then
    echo "Please enter [username] after setup.sh"
    exit 1
fi

# Check user is valid or not
USERNAME=$1
grep -Fq "/home/${USERNAME}:" /etc/passwd
if [ $? -eq 1 ]; then
    echo "${USERNAME} is not registered in the system"
    exit 1
fi
echo "Setup environment for user '${USERNAME}'"

# Install neovim editor
# ====================================================================
apt-get install -y software-properties-common
add-apt-repository -y ppa:neovim-ppa/stable
apt-get update
apt-get install -y neovim
apt-get install -y python-dev python-pip python3-dev python3-pip
python -m pip install neovim
python3 -m pip install neovim
python3 -m pip install pynvim

# Change editor alternatives
update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
update-alternatives --set vi
update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
update-alternatives --set vim
update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
update-alternatives --set editor

# Setup configuration file
NVIM_DIR="/home/${USERNAME}/.config/nvim"
mkdir -p ${NVIM_DIR}
cp neovim/init.vim "${NVIM_DIR}/init.vim"

# Install vim-plug plugin manager
VIM_PLUG_URL="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
VIM_PLUG_DIR="/home/${USERNAME}/.local/share/nvim/site/autoload"
LOCAL_DIR="/home/${USERNAME}/.local"
mkdir -p ${VIM_PLUG_DIR}
wget -O "${VIM_PLUG_DIR}/plug.vim" ${VIM_PLUG_URL}

# Update file permission
chown -R ${USERNAME}:${USERNAME} ${NVIM_DIR}
chown -R ${USERNAME}:${USERNAME} ${VIM_PLUG_DIR}
chown -R ${USERNAME}:${USERNAME} ${LOCAL_DIR}

# Install tmux
# =====================================================================
apt-get install -y tmux

# Setup configuration file
TMUX_CONF_FILE="/home/${USERNAME}/.tmux.conf"
cp "tmux/tmux.conf" ${TMUX_CONF_FILE}

# Update file permission
chown ${USERNAME}:${USERNAME} ${TMUX_CONF_FILE}

# Install pyenv & pyenv virtualenv
# =====================================================================
PYENV_DIR="/home/${USERNAME}/.pyenv"
PYENV_URL="https://github.com/pyenv/pyenv.git"
PYENV_VIRT_URL="https://github.com/pyenv/pyenv-virtualenv.git"

if [ ! -d ${PYENV_DIR} ]; then
    git clone ${PYENV_URL} ${PYENV_DIR}
    mkdir -p "${PYENV_DIR}/plugins"
    git clone ${PYENV_VIRT_URL} "${PYENV_DIR}/plugins/pyenv-virtualenv"
    chown ${USERNAME}:${USERNAME} ${PYENV_DIR}
fi

# Install zsh shell
# =====================================================================
apt-get install -y zsh

# (User should change the shell manually) Change user shell
usermod --shell /bin/zsh ${USERNAME}

# Setup configuration files
ZSHRC="/home/${USERNAME}/.zshrc"
cp zsh/zshrc ${ZSHRC}
chown ${USERNAME}:${USERNAME} ${ZSHRC}

# Install oh-my-zsh plugins
OH_MY_ZSH_DIR="/home/${USERNAME}/.oh-my-zsh"
OH_MY_ZSH_CUSTOM_DIR="${OH_MY_ZSH_DIR}/custom"
OH_MY_ZSH_PLUGIN_DIR="${OH_MY_ZSH_CUSTOM_DIR}/plugins"

OH_MY_ZSH_URL="https://github.com/robbyrussell/oh-my-zsh.git"

ZSH_AUTOSUGGESTION_DIR="${OH_MY_ZSH_PLUGIN_DIR}/zsh-autosuggestions"
ZSH_AUTOSUGGESTION_URL="https://github.com/zsh-users/zsh-autosuggestions.git"

ZSH_SYNTAX_HIGHLIGHT_DIR="${OH_MY_ZSH_PLUGIN_DIR}/zsh-syntax-highlighting"
ZSH_SYNTAX_HIGHLIGHT_URL="https://github.com/zsh-users/zsh-syntax-highlighting.git"

ZSH_PYENV_DIR="${OH_MY_ZSH_PLUGIN_DIR}/zsh-pyenv"
ZSH_PYENV_URL="https://github.com/mattberther/zsh-pyenv.git"

if [ ! -d ${OH_MY_ZSH_DIR} ]; then
    git clone ${OH_MY_ZSH_URL} ${OH_MY_ZSH_DIR}
fi

cp zsh/aliases.zsh ${OH_MY_ZSH_CUSTOM_DIR}
cp zsh/exports.zsh ${OH_MY_ZSH_CUSTOM_DIR}
cp zsh/robbyrussell.zsh-theme ${OH_MY_ZSH_CUSTOM_DIR}

if [ ! -d ${OH_MY_ZSH_PLUGIN_DIR} ]; then
    mkdir -p ${OH_MY_ZSH_PLUGIN_DIR}
fi

if [ ! -d ${ZSH_AUTOSUGGESTION_DIR} ]; then
    git clone ${ZSH_AUTOSUGGESTION_URL} ${ZSH_AUTOSUGGESTION_DIR}
fi

if [ ! -d ${ZSH_SYNTAX_HIGHLIGHT_DIR} ]; then
    git clone ${ZSH_SYNTAX_HIGHLIGHT_URL} ${ZSH_SYNTAX_HIGHLIGHT_DIR}
fi

if [ ! -d ${ZSH_PYENV_DIR} ]; then
    git clone ${ZSH_PYENV_URL} ${ZSH_PYENV_DIR}
fi

chown -R ${USERNAME}:${USERNAME} ${OH_MY_ZSH_DIR}

# Install Handy tools
apt-get install -y \
    ctags \
    htop \
    ncdu \
    net-tools

# Install pyenv prerequisites libraries
apt install -y \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    curl \
    virtualenv \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libxml2-dev \
    libxmlsec1-dev \
    libffi-dev \
    liblzma-dev

snap install ripgrep --classic

if [[ -z "${XDG_SESSION_DESKTOP}" && "${XDG_SESSION_DESKTOP}" == "i3" ]]; then
    # Install Pinyin input type (Add input method on the top right toolbar)
    # ========================================================================
    apt-get install -y fcitx fcitx-chewing

    # Change input type whenever login into the system
    XINITRC="/home/${USERNAME}/.xinitrc"
    XRESOURCE="/home/${USERNAME}/.Xresources"
    cp xserver/xinitrc ${XINITRC}
    cp xserver/Xresources ${XRESOURCE}
    chown ${USERNAME}:${USERNAME} ${XINITRC}
    chown ${USERNAME}:${USERNAME} ${XRESOURCE}

    # Configure i3 environment
    # =========================================================================
    apt install -y \
                feh \
                acpi \
                rofi \
                clipit \
                locate \
                xbacklight \
                alsa-tools \
                terminator \
                libnotify-bin \
                pulseaudio-utils \
                fonts-font-awesome

    WM_CONFIG_DIR="/home/${USERNAME}/.config/i3"
    mkdir -p ${WM_CONFIG_DIR}
    cp -r i3wm/* ${WM_CONFIG_DIR}
    chown -R ${USERNAME}:${USERNAME} ${SSH_DIR}

    BAR_CONFIG_DIR="/home/${USERNAME}/.config/i3blocks"
    if [ ! -d ${BAR_CONFIG_DIR} ]; then
        mkdir -p ${BAR_CONFIG_DIR}
        cp -r i3blocks/* ${BAR_CONFIG_DIR}
        chown -R ${USERNAME}:${USERNAME} ${BAR_CONFIG_DIR}
    fi

    # Install lightweight terminal
    # =========================================================================
    apt-get install -y rxvt-unicode xsel

    # Install perl-extensions system-wide
    PERL_EXT_DIR="/home/${USERNAME}/.urxvt/ext"
    if [ ! -d ${PERL_EXT_DIR} ]; then
        mkdir -p ${PERL_EXT_DIR}
        git clone "https://github.com/muennich/urxvt-perls.git" /tmp
        cp /tmp/urxvt-perls/keyboard-select ${PERL_EXT_DIR}
        cp /tmp/urxvt-perls/deprecated/url-select ${PERL_EXT_DIR}
        cp /tmp/urxvt-perls/deprecated/clipboard ${PERL_EXT_DIR}
        chown -R ${USERNAME}:${USERNAME} ${PERL_EXT_DIR}
    fi
fi
