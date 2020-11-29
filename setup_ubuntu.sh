#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
PACKAGES=(tmux zsh nodejs gcc g++ make)

run_config_scripts() {
    # Install ZSH
    echo "Installing ZSH..."
    sh -c './install_zsh.sh'

    # Install neovim
    echo "Installing Neovim..."
    sh -c './install_neovim.sh'

    # Install config files
    echo "Installing config files..."
    sh -c './install_config.sh'
}

add_sources() {
    # Add NodeJS source
    curl -sL https://deb.nodesource.com/setup_15.x | sudo -E bash -
}

install_packages() {
    sudo apt update
    for i in "${PACKAGES[@]}"
    do
        echo "Installing $i..."
        sudo apt-get install -y $i
    done
}

install_packages
