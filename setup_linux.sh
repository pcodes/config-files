#!/bin/bash

SCRIPTPATH="$(
    cd "$(dirname "$0")" > /dev/null 2>&1 || exit
    pwd -P
)"

function install_nerdfont() {
    echo "Running nerdfont install script..."
    bash $SCRIPTPATH/scripts/nerd_font_installer.sh FiraCode --file-name "Fira Code"
}

function install_dotfiles() {
    bash $SCRIPTPATH/install_dotfiles.sh --all
}

function install_alacritty_theme() {
    echo "Downloading catppuccin Alacritty theme..."
    mkdir -p $HOME/.config/alacritty
}

function install_packages_from_manager () {
    fedora_desktop=(alacritty i3 polybar rofi)
    fedora_packages=(zsh gh tmux neovim g++ curl neofetch bat lsd python3-pip nodejs-bash-language-server ranger fzf speedtest-cli go)
    
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

function install_pip_packages() {
    pip_packages=(neovim)

    echo "Downloading pip packages..."
    for i in "${pip_packages[@]}"
    do
        pip3 install --user "$i"
    done
}

function change_shell (){
    echo "Changing shell to ZSH..."
    chsh -s $(which zsh)
}


function helptext() {
    echo "Script to install dependencies and create symlinks for config files."
    echo "USAGE: ./install_config.sh ARGS"
    echo "Arguments:"
    echo -e "--ohmy\t\tInstall Oh my ZSH"
    echo -e "--custom\t\tInstall Oh My Zsh custom plugins"
    echo -e "--theme\t\tInstall ZSH theme"
    echo -e "--other_symlinks\t\tCreate symlinks for non-nvim configs"
    echo -e "--nvim_symlinks\t\tCreate symlinks for all nvim configs"
}

while [[ $# -gt 0 ]]; do
    key="$1"

    case $key in
    --all)
        shift # shift past the argument
        INSTALL_PACKAGES=true
        if [[ $1 == "--desltop" ]]; then
            DESKTOP_INSTALL=true
        fi

        INSTALL_PIP_PACKAGES=true
        CHANGE_SHELL=true
        ALACRITTY_THEME=true
        NERDFONT=true
        DOTFILES=true

        echo "Not implemented"
        ;;
    --linux_packages)
        shift
        INSTALL_PACKAGES=true
        if [[ $1 == "--desktop" ]]; then
            shift
            DESKTOP_INSTALL=true
        fi
        ;;
    --pip_packages)
        shift
        INSTALL_PIP_PACKAGES=true
        ;;
    --change_shell)
        shift
        CHANGE_SHELL=true
        ;;
    --alacritty_theme)
        shift
        ALACRITTY_THEME=true
        ;;
    --nerdfont)
        shift
        NERDFONT=true
        ;;
    --dotfiles)
        shift
        DOTFILES=true
        ;;
    --help)
        shift
        helptext
        exit
        ;;
    *)
        echo "ERROR: $key is unrecognized"
        exit
    esac
done

if [[ -n $INSTALL_PACKAGES ]]; then
    if [[ -n $DESKTOP_INSTALL ]]; then
        install_packages_from_manager "desktop"
    else
        install_packages_from_manager
    fi
fi

if [[ -n $DOTFILES ]]; then
    install_dotfiles
fi

if [[ -n $INSTALL_PIP_PACKAGES ]]; then
    install_pip_packages
fi

if [[ -n $CHANGE_SHELL ]]; then
    change_shell
fi

if [[ -n $ALACRITTY_THEME ]]; then
    install_alacritty_theme
fi

if [[ -n $NERDFONT ]]; then
    install_nerdfont
fi

if [[ -n $INSTALL_TMUX_PACKAGES ]]; then
    run_tmux_package_install
fi
