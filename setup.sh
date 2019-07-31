#!/bin/bash

echo "Creating repository directories..."
mkdir -p ~/code/personal
mkdir -p ~/code/work
mkdir -p ~/code/others

echo "Updating apt-get..."
sudo apt-get -y update
sudo apt-get -y upgrade
