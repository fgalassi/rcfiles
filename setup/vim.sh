#!/usr/bin/env sh

ln -sfT rcfiles/vim       ~/.vim
ln -sfT rcfiles/vim/vimrc ~/.vimrc
vim +BundleInstall +qall
