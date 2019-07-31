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
