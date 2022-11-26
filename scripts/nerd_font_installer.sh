#!/bin/bash

echo "Downloading $1 Nerd Font..."
wget -q -O ~/Downloads/font.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$1.zip
mkdir ~/Downloads/font_tmp
echo "Font downloaded, unzipping..."
unzip -d ~/Downloads/font_tmp ~/Downloads/font.zip 

if [[ "$2" == "--download-only" ]]; then
    exit
fi

if [[ "$2" == "--file-name" ]]; then
    FILE_NAME="$3 Regular Nerd Font Complete.ttf"
else
    FILE_NAME="$1 Regular Nerd Font Complete.ttf"
fi

echo "Font unzipped, now copying it to system font cache (will require sudo)..."
sudo cp "$HOME/Downloads/font_tmp/$FILE_NAME" /usr/share/fonts
echo "Refreshing font cache (will require sudo)..."
sudo fc-cache -f -v
echo "Cleaning up..."
rm -rf ~/Downloads/font_tmp
rm ~/Downloads/font.zip
