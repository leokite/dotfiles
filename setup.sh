#!/bin/bash

# synbolic link
DOT_FILES=(.gitconfig .tmux.conf .vimrc .zshrc .zshrc.custom .zshrc.alias .zshrc.osx .zshrc.linux)
for file in ${DOT_FILES[@]}
do
    ln -s $HOME/dotfiles/$file $HOME/$file
done

# install oh-my-zsh
[! -d ~/.oh-my-zsh ] && git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# install z
cd $HOME
git clone https://github.com/rupa/z.git

# install Neobundle
mkdir -p ~/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
