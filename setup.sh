#!/bin/bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `osx.sh` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "Creating repository directories..."
mkdir -p ~/code/personal
mkdir -p ~/code/work
mkdir -p ~/code/others

echo "Updating apt-get..."
sudo apt-get -y update
sudo apt-get -y upgrade

echo "Installing packages..."

echo "Installing essentials..."
sudo apt-get install -y build-essential python-dev python-setuptools python-pip python-smbus
sudo apt-get install -y libffi-dev
sudo apt-get install -y zlib1g-dev libsqlite3-dev tk-dev
sudo apt-get install -y libssl-dev openssl
sudo apt-get install -y moreutils
sudo apt-get install -y findutils
sudo apt-get install -y curl
sudo apt-get install -y file
sudo apt-get install -y git
sudo apt-get install -y tmux
sudo apt-get install -y ruby
sudo apt-get install -y zsh

echo "Installing useful binaries..."
sudo apt-get install -y ack
sudo apt-get install -y cmake
sudo apt-get install -y entr
sudo apt-get install -y fzf
sudo apt-get install -y git-extras
sudo apt-get install -y git-flow
sudo apt-get install -y git-lfs
sudo apt-get install -y imagemagick
sudo apt-get install -y peco
sudo apt-get install -y tig
sudo apt-get install -y tldr
sudo apt-get install -y tree
sudo apt-get install -y watch
sudo apt-get install -y xsel

sudo snap install ripgrep --classic

echo "Installing google cloud..."
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
sudo apt-get install -y apt-transport-https ca-certificates
echo "deb https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get update && sudo apt-get install -y google-cloud-sdk

# Install ASDF (Extendable Version Manager for multiple language runtime versions)
git clone https://github.com/asdf-vm/asdf.git ~/.asdf
cd ~/.asdf || exit
git checkout "$(git describe --abbrev=0 --tags)"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "${DIR}" || exit

#############
# Dotfiles  #
#############

echo "Syncing dotfiles..."
git clone https://github.com/aaronmak/dotfiles.git ~/code/personal/dotfiles
cd ~/code/personal/dotfiles || exit
rake install

#############
# oh-my-zsh #
#############

echo "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Custom Plugins
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

git clone "https://github.com/zsh-users/zsh-autosuggestions" "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"

# Install spaceship theme
git clone "https://github.com/denysdovhan/spaceship-prompt.git" "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

##########
# NEOVIM #
##########

echo "Installing neovim..."
sudo apt-get install -y neovim

# Create required required directories and files for neovim configs
mkdir -p ~/.config/nvim
touch "$HOME/.config/nvim/init.vim"

cat <<EOT > "$HOME/.config/nvim/init.vim"
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
EOT

# Install vim-plug as plugin manager
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
