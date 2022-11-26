#!/bin/bash

cat << "EOF"
 ____              _       _                     _     _                  
| __ )  ___   ___ | |_ ___| |_ _ __ __ _ _ __   | |   (_)_ __  _   ___  __
|  _ \ / _ \ / _ \| __/ __| __| '__/ _` | '_ \  | |   | | '_ \| | | \ \/ /
| |_) | (_) | (_) | |_\__ \ |_| | | (_| | |_) | | |___| | | | | |_| |>  < 
|____/ \___/ \___/ \__|___/\__|_|  \__,_| .__/  |_____|_|_| |_|\__,_/_/\_\
                                        |_|                               
EOF

echo -e "Currently, this only works for Fedora Linux\n"

echo "Downloading Github CLI tool"
sudo dnf install -y gh

echo "Running gh to sign in and create new SSH key"
gh auth login

echo "Creating directory for storing repos"
mkdir -p ~/Code/util

echo "Cloning config file repo"
gh repo clone pcodes/config-files ~/Code/util/config-files

cat << "EOF"
 _____ _       _     _              _ _ 
|  ___(_)_ __ (_)___| |__   ___  __| | |
| |_  | | '_ \| / __| '_ \ / _ \/ _` | |
|  _| | | | | | \__ \ | | |  __/ (_| |_|
|_|   |_|_| |_|_|___/_| |_|\___|\__,_(_)
                                        
EOF

echo "Please run ~/Code/util/config-files/setup_linux.sh to continue"

