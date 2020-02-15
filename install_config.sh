#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

FILES=("tmux.conf" "gitconfig" "vimrc" "zshrc")
for i in "${!FILES[@]}"; do
        echo "Copying " + ${FILES[$i]}
        ln -sf $SCRIPTPATH/${FILES[$i]} ~/.${FILES[$i]}
done
