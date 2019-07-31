#!/bin/bash

echo "Creating repository directories..."
mkdir -p ~/code/personal
mkdir -p ~/code/work
mkdir -p ~/code/others

echo "Updating apt-get..."
sudo apt-get -y update
sudo apt-get -y upgrade

echo "Installing packages..."

echo "Installing essentials..."
sudo apt-get install -y build-essential
sudo apt-get install -y moreutils
sudo apt-get install -y findutils
sudo apt-get install -y curl
sudo apt-get install -y file
sudo apt-get install -y git
sudo apt-get install -y tmux
sudo apt-get install -y ruby
sudo apt-get install -y zsh

echo "Installing homebrew..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile

echo "git clone dotfiles and setup scripts"
git clone git://github.com:aaronmak/dotfiles.git ~/code/personal/dotfiles
cd ~/code/personal/dotfiles || exit
rake install

# TODO: stop using homebrew
git clone git://github.com:aaronmak/mac-setup.git ~/code/personal/mac-setup
cd ~/code/personal/mac-setup || exit
./brew.sh
./oh-my-zsh.sh

echo "Install google cloud"
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
sudo apt-get install apt-transport-https ca-certificates
echo "deb https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get update && sudo apt-get install google-cloud-sdk


