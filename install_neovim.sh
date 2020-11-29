#!/bin/bash

# Download latest neovim nightly (because #yolo)
wget -O /tmp/nvim https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod u+x /tmp/nvim
# Don't want to sudo wget something
sudo mv /tmp/nvim /usr/bin/nvim

# Check if VimPlug is installed, and if not install it
if [[ -z "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim ]]
then
	echo "VimPlug not installed, cloning from Github..."
	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
		       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

echo "Neovim has been installed or updated!"
