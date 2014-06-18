#!/usr/bin/env sh

RC_DIR="$( cd "$( dirname "$0" )/.." && pwd )"
cd $HOME
ln -sf "$RC_DIR/git/gitconfig" .gitconfig

# go to git repository root directory
cd rcfiles
cd $(git rev-parse --show-toplevel)

git submodule init
git submodule update
