#!/usr/bin/env bash


# A script to install Google Chrome and its dependencies on Ubuntu Noble

# Update package lists to ensure the latest versions are fetched
sudo apt update

# Install required dependencies for Google Chrome
sudo apt install -y wget apt-transport-https software-properties-common

# Download the Google Chrome .deb package
wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O google-chrome-stable.deb

# Install the downloaded .deb package using dpkg
sudo dpkg -i google-chrome-stable.deb

# Fix any missing dependencies if needed
sudo apt install -f -y

# Clean up by removing the downloaded .deb file
rm -f google-chrome-stable.deb

# Verify installation
if command -v google-chrome >/dev/null 2>&1; then
    echo "Google Chrome has been successfully installed."
else
    echo "Installation failed. Please check for errors and try again."
fi
