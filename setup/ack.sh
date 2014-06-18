#!/usr/bin/env sh

RC_DIR="$( cd "$( dirname "$0" )/.." && pwd )"
cd $HOME
ln -sf "$RC_DIR/ack/ackrc" .ackrc
