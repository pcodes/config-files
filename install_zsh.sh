#!/bin/bash

install_mac_packages() {
        brew install zsh cowsay fortune lsd
}

install_ubuntu_packages() {
        sudo apt install zsh cowsay fortune
        wget -O /tmp/lsd.deb https://github.com/Peltoche/lsd/releases/download/0.16.0/lsd_0.16.0_amd64.deb
        sudo dpkg -i /tmp/lsd.deb
}

main() {
        # install zsh and other needed packages
        if [[ "$OSTYPE" =~ "darwin" ]]; then
                install_mac_packages
        else
                install_ubuntu_packages
        fi
        
        # change default shell to zsh
        chsh -s /bin/zsh

        # install oh my zsh
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

        # download p10k
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
        # run p10k setup
}

main "$@"
