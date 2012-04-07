#!/usr/bin/env sh

# go to git repository root directory
cd $(git rev-parse --show-toplevel)

git submodule init
git submodule update
