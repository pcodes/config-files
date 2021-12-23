#!/bin/bash

SCRIPTPATH="$(
	cd "$(dirname "$0")" >/dev/null 2>&1 || exit
	pwd -P
)"
# Files that sit in the home dir
HOME_DIR_FILES=("tmux.conf" "gitconfig" "zshrc")

function install_oh_my_zsh() {
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

function install_custom_zsh_plugins() {
	git clone https://github.com/TamCore/autoupdate-oh-my-zsh-plugins "$ZSH_CUSTOM"/plugins/autoupdate
	git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting
}

function install_zsh_theme() {
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/themes/powerlevel10k
}

function create_other_symlinks() {
	for i in "${!HOME_DIR_FILES[@]}"; do
		echo "Copying " + "${HOME_DIR_FILES[$i]}"
		ln -sf "$SCRIPTPATH"/config/"${HOME_DIR_FILES[$i]}" ~/."${HOME_DIR_FILES[$i]}"
	done
}

function create_nvim_symlinks() {
	mkdir -p "$HOME"/.config/nvim/lua
	LUA_FILES=($(ls "$SCRIPTPATH"/config/nvim/lua))

	ln -sf "$SCRIPTPATH"/config/nvim/init.lua ~/.config/nvim/init.lua

	for i in "${!LUA_FILES[@]}"; do
		echo "Copying " + "${LUA_FILES[$i]}"
		ln -sf "$SCRIPTPATH"/config/nvim/lua/"${LUA_FILES[$i]}" ~/.config/nvim/lua/"${LUA_FILES[$i]}"
	done

}

# Create config directory
#mkdir -p $HOME/.config/nvim

# Install neovim specific files
#ln -sf $SCRIPTPATH/config/neovim.vim ~/.config/nvim/init.vim
#ln -sf $SCRIPTPATH/config/coc-settings.json ~/.config/nvim/coc-settings.json

install_zsh_theme
