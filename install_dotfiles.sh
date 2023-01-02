#!/bin/bash

SCRIPTPATH="$(
    cd "$(dirname "$0")" >/dev/null 2>&1 || exit
    pwd -P
)"
# Files that sit in the home dir
HOME_DIR_FILES=("tmux.conf" "gitconfig" "zshrc")

function install_oh_my_zsh() {
    echo "Running Oh My ZSH installer..."
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
    ln -sf "$SCRIPTPATH"/dotfiles/config/nvim/.luarc.json ~/.config/nvim/.luarc.json

    for i in "${!LUA_FILES[@]}"; do
        echo "Copying " + "${LUA_FILES[$i]}"
        ln -sf "$SCRIPTPATH"/dotfiles/config/nvim/lua/"${LUA_FILES[$i]}" ~/.config/nvim/lua/"${LUA_FILES[$i]}"
    done

    ln -sf "$SCRIPTPATH"/dotfiles/config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
    ln -sf "$SCRIPTPATH"/dotfiles/config/i3/config ~/.config/i3/config

}

function run_nvim_package_install() {
    nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
}

function run_tmux_package_install() {
    # start a server but don't attach to it
    tmux start-server
    # create a new session but don't attach to it either
    tmux new-session -d
    # install the plugins
    ~/.tmux/plugins/tpm/scripts/install_plugins.sh
    # killing the server is not required, I guess
    tmux kill-server
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
        INSTALL_CONFIGDIR_SYMLINKS=true
        INSTALL_HOMEDIR_SYMLINKS=true
        INSTALL_NVIM_PACKAGES=true
        INSTALL_TMUX_PACKAGES=true
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
    --packager_manager_run)
        shift
        INSTALL_NVIM_PACKAGES=true
        INSTALL_TMUX_PACKAGES=true
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
    install_oh_my_zsh
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

if [[ -n $INSTALL_NVIM_PACKAGES ]]; then
    run_nvim_package_install
fi

if [[ -n $INSTALL_TMUX_PACKAGES ]]; then
    run_tmux_package_install
fi
