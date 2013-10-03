#!/usr/bin/env sh

SETUP_DIR="$( pwd -P )"

mkdir -p ~/.fonts
cp $SETUP_DIR/fonts/* ~/.fonts
fc-cache ~/.fonts
