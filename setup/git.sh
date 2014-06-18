#!/usr/bin/env sh

ln -sfT rcfiles/git/gitconfig ~/.gitconfig

# go to git repository root directory
cd rcfiles
cd $(git rev-parse --show-toplevel)

git submodule init
git submodule update
