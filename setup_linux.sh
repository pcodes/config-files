#!/bin/bash

set_os() {
    if [[ "$(uname -s)" == "Darwin" ]]; then
        os_name="MacOS"
        return 0
    fi
    
    . /etc/os-release
    os_name="$NAME"
}

install_packages_from_manager () {
    fedora_desktop=(alacritty polybar rofi)

    fedora_packages=(zsh gh tmux neovim g++ curl neofetch bat lsd python3-pip nodejs-bash-language-server ranger fzf speedtest-cli go)

}

set_os
