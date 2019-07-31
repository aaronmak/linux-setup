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
