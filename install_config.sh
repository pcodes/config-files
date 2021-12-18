#!/bin/bash
function install_zsh_theme() {
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
}


# SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
#FILES=("tmux.conf" "gitconfig" "zshrc")

#for i in "${!FILES[@]}"; do
#        echo "Copying " + ${FILES[$i]}
#        ln -sf $SCRIPTPATH/config/${FILES[$i]} ~/.${FILES[$i]}
#done

# Create config directory
#mkdir -p $HOME/.config/nvim

# Install neovim specific files
#ln -sf $SCRIPTPATH/config/neovim.vim ~/.config/nvim/init.vim
#ln -sf $SCRIPTPATH/config/coc-settings.json ~/.config/nvim/coc-settings.json

install_zsh_theme
