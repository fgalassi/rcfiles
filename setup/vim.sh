#!/usr/bin/env sh

RC_DIR="$( cd "$( dirname "$0" )/.." && pwd )"
cd $HOME
ln -sf "$RC_DIR/vim"       .vim
ln -sf "$RC_DIR/vim/vimrc" .vimrc
vim +BundleInstall +qall
