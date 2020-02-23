#!/bin/bash

# synbolic link
DOT_FILES=(.gitconfig .gitconfig-work .gitconfig-private .tmux.conf .vimrc .gvimrc .vrapperrc .zshrc .zshrc.custom .zshrc.alias .zshrc.osx .zshrc.linux)
for file in ${DOT_FILES[@]}
do
    ln -s $HOME/dotfiles/$file $HOME/$file
done

# install oh-my-zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# install z
cd $HOME
git clone https://github.com/rupa/z.git

# install Vundle
mkdir -p ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
