#!/usr/bin/env sh

RC_DIR="$( cd "$( dirname "$0" )/.." && pwd )"
cd $HOME
mkdir -p .fonts
cp "$RC_DIR"/fonts/* .fonts
fc-cache ~/.fonts
