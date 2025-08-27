#!/bin/bash

mkdir -p "$HOME/.config/nvim"
cp neovim.init.vim "$HOME/.config/nvim/init.vim"
curl -fLo "$HOME/.local/share/nvim/site/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cp zshrc "$HOME/.zshrc"

if [ ! -d "$HOME/.oh-my-zsh" ]; then
	git clone https://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh"
fi

cp exports.zsh "$HOME/.oh-my-zsh/custom"
cp aliases.zsh "$HOME/.oh-my-zsh/custom"
cp robbyrussell.zsh-theme "$HOME/.oh-my-zsh/custom"

mkdir -p "$HOME/.oh-my-zsh/custom/plugins"
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
	git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
fi
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-pyenv" ]; then
	git clone https://github.com/mattberther/zsh-pyenv.git $HOME/.oh-my-zsh/custom/plugins/zsh-pyenv
fi

cp tmux.conf $HOME/.tmux.conf
