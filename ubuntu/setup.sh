#!/bin/bash

TOP=$(pwd)

if [ $USER != "root" ]; then
    echo "Please execute setup.sh with sudo permission"
    exit 1
fi

if [ $# -ne 1 ]; then
    echo "Please enter [username] after setup.sh"
    exit 1
fi

USERNAME=$1
grep -Fq "/home/${USERNAME}:" /etc/passwd
if [ $? -eq 1 ]; then
    echo "${USERNAME} is not registered in the system"
    exit 1
fi
echo "Setup environment for user '${USERNAME}'"

apt-get install -y software-properties-common
add-apt-repository -y ppa:neovim-ppa/stable
apt-get update
apt-get install -y \
	abootimg \
	binfmt-support \
	binutils \
	build-essential \
	cpio \
	cpp \
	ctags \
	curl \
	device-tree-compiler \
	dosfstools \
	htop \
	zsh \
	lbzip2 \
	libbz2-dev \
	libffi-dev \
	liblzma-dev \
	libncursesw5-dev \
	libreadline-dev \
	libsqlite3-dev \
	libssl-dev \
	libxml2-dev \
	libxml2-utils \
	libxmlsec1-dev \
	ncdu \
	neovim \
	net-tools \
	nfs-kernel-server \
	openssl \
	python3-dev \
	python3-pip
	python3-yaml \
	qemu-user-static \
	sshpass \
	tk-dev \
	tmux \
	udev \
	uuid-runtime \
	virtualenv \
	whois \
	xz-utils \
	zlib1g-dev

# Change editor alternatives
update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
update-alternatives --set vi
update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
update-alternatives --set vim
update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
update-alternatives --set editor

# Setup neovim configuration file
su - $USERNAME -c "mkdir -p $HOME/.config/nvim"
su - $USERNAME -c "cp $TOP/neovim.init.vim $HOME/.config/nvim/init.vim"
su - $USERNAME -c "curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

usermod --shell /bin/zsh ${USERNAME}
su - $USERNAME -c "cp $TOP/zshrc $HOME/.zshrc"
su - $USERNAME -c "cp $TOP/tmux.conf $HOME/.tmux.conf"

if [ ! -d "/home/$USERNAME/.oh-my-zsh" ]; then
	su - $USERNAME -c "git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh"
fi

su - $USERNAME -c "cp $TOP/exports.zsh $HOME/.oh-my-zsh/custom"
su - $USERNAME -c "cp $TOP/aliases.zsh $HOME/.oh-my-zsh/custom"
su - $USERNAME -c "cp $TOP/robbyrussell.zsh-theme $HOME/.oh-my-zsh/custom"
su - $USERNAME -c "mkdir -p $HOME/.oh-my-zsh/custom/plugins"

if [ ! -d "/home/$USERNAME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
	su - $USERNAME -c "git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
fi
if [ ! -d "/home/$USERNAME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
	su - $USERNAME -c "git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
fi
if [ ! -d "/home/$USERNAME/.oh-my-zsh/custom/plugins/zsh-pyenv" ]; then
	su - $USERNAME -c "git clone https://github.com/mattberther/zsh-pyenv.git $HOME/.oh-my-zsh/custom/plugins/zsh-pyenv"
fi
