#!/bin/bash

SCRIPTPATH="$(
    cd "$(dirname "$0")" > /dev/null 2>&1 || exit
    pwd -P
)"

install_packages_from_manager () {
    fedora_desktop=(alacritty polybar rofi)
    fedora_packages=(zsh gh tmux neovim g++ curl neofetch bat lsd python3-pip nodejs-bash-language-server ranger fzf speedtest-cli go i3)
    
    echo "Downloading core Fedora packages..."
    for i in "${fedora_packages[@]}"
    do
        sudo dnf install -y "$i"
    done

    if [[ "$1" == "desktop" ]]; then
        echo "Fedora Desktop packages requested, downloading..."
        for i in "${fedora_desktop[@]}"
        do
            sudo dnf install -y "$i"
        done
    fi
}

install_pip_packages() {
    pip_packages=(neovim)

    echo "Downloading pip packages..."
    for i in "${pip_packages[@]}"
    do
        pip3 install --user "$i"
    done
}

change_shell (){
    echo "Changing shell to ZSH..."
    chsh -s $(which zsh)
}
