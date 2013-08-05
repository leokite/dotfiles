#!/bin/bash

DOT_FILES=(.gitconfig .tmux.conf .vimrc .zshrc .zshrc.custom .zshrc.alias .zshrc.osx .zshrc.linux)

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/dotfiles/$file $HOME/$file
done

# install oh-my-zsh
[! -d ~/.oh-my-zsh ] && git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# install Neobundle
mkdir -p ~/.vim/bundle
git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
