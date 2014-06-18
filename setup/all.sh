#!/usr/bin/env sh

SETUP_DIR="$( cd "$( dirname "$0" )" && pwd )"
echo 
"$SETUP_DIR/git.sh"
"$SETUP_DIR/vim.sh"
"$SETUP_DIR/ack.sh"
"$SETUP_DIR/fonts.sh"
