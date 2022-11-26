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
    git clone https://github.com/TamCore/autoupdate-oh-my-zsh-plugins $ZSH_CUSTOM/plugins/autoupdate
    git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
}

function install_zsh_theme() {
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/themes/powerlevel10k
}

function create_homedir_symlinks() {
    for i in "${!HOME_DIR_FILES[@]}"; do
        echo "Copying " + "${HOME_DIR_FILES[$i]}"
        ln -sf "$SCRIPTPATH"/dotfiles/"${HOME_DIR_FILES[$i]}" ~/."${HOME_DIR_FILES[$i]}"
    done
}

function create_configdir_symlinks() {
    mkdir -p $HOME/.config/nvim/lua
    mkdir -p $HOME/.config/alacritty
    mkdir -p $HOME/.config/i3

    LUA_FILES=($(ls "$SCRIPTPATH"/dotfiles/config/nvim/lua))

    ln -sf "$SCRIPTPATH"/dotfiles/config/nvim/init.lua ~/.config/nvim/init.lua

    for i in "${!LUA_FILES[@]}"; do
        echo "Copying " + "${LUA_FILES[$i]}"
        ln -sf "$SCRIPTPATH"/dotfiles/config/nvim/lua/"${LUA_FILES[$i]}" ~/.config/nvim/lua/"${LUA_FILES[$i]}"
    done

    ln -sf "$SCRIPTPATH"/dotfiles/config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
    ln -sf "$SCRIPTPATH"/dotfiles/config/i3/config ~/.config/i3/config

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
        INSTALL_OH_MY_ZSH=true
        INSTALL_ZSH_CUSTOM=true
        INSTALL_ZSH_THEME=true
        INSTALL_OTHER_SYMLINKS=true
        INSTALL_NVIM_SYMLINKS=true
        ;;
    --ohmy)
        shift
        INSTALL_OH_MY_ZSH=true
        ;;
    --custom)
        shift
        INSTALL_ZSH_CUSTOM=true
        ;;
    --theme)
        shift
        INSTALL_ZSH_THEME=true
        ;;
    --homedir_symlinks)
        shift
        INSTALL_HOMEDIR_SYMLINKS=true
        ;;
    --configdir_symlinks)
        shift
        INSTALL_CONFIGDIR_SYMLINKS=true
        ;;
    --symlinks)
        shift
        INSTALL_CONFIGDIR_SYMLINKS=true
        INSTALL_HOMEDIR_SYMLINKS=true 
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

if [[ -n $INSTALL_OH_MY_ZSH ]]; then
    echo "Installing oh my zsh"
    #install_oh_my_zsh
fi

if [[ -n $INSTALL_ZSH_CUSTOM ]]; then
    install_custom_zsh_plugins
fi

if [[ -n $INSTALL_ZSH_THEME ]]; then
    install_zsh_theme
fi

if [[ -n $INSTALL_HOMEDIR_SYMLINKS ]]; then
    create_homedir_symlinks
fi

if [[ -n $INSTALL_CONFIGDIR_SYMLINKS ]]; then
    create_configdir_symlinks
fi
