#!/bin/bash

# Exit if any command fails
set -e

echo "Installing Alacritty using apt via PPA..."

# Step 1: Add the Alacritty PPA
sudo add-apt-repository ppa:aslatter/ppa -y

# Step 2: Update the package list
sudo apt update

# Step 3: Install Alacritty
sudo apt install -y alacritty

# Step 4: Verify installation
if command -v alacritty &> /dev/null; then
    echo "Alacritty successfully installed! Run 'alacritty' to start the terminal."
else
    echo "Failed to install Alacritty. Please check for errors."
fi
