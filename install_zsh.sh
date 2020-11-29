#!/bin/bash

install_mac_packages() {
        brew install zsh cowsay fortune lsd
}

install_ubuntu_packages() {
        sudo apt install zsh cowsay fortune
        wget -O /tmp/lsd.deb https://github.com/Peltoche/lsd/releases/download/0.18.0/lsd_0.18.0_amd64.deb
        sudo dpkg -i /tmp/lsd.deb
}

main() {
        # install zsh and other needed packages
        if [[ "$OSTYPE" =~ "darwin" ]]; then
                install_mac_packages
        else
                install_ubuntu_packages
        fi

        # install oh my zsh
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

	# Install ZSH plugins
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

        # download p10k
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
}

main "$@"
