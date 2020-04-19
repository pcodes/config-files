#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
FILES=("tmux.conf" "gitconfig" "zshrc")

for i in "${!FILES[@]}"; do
        echo "Copying " + ${FILES[$i]}
        ln -sf $SCRIPTPATH/config/${FILES[$i]} ~/.${FILES[$i]}
done

# Install neovim specific files
ln -sf $SCRIPTPATH/config/neovim.vim ~/.config/nvim/init.vim
ln -sf $SCRIPTPATH/config/coc-settings.json ~/.config/nvim/coc-settings.json
