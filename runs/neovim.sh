#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

# Check if required dependencies are installed
dependencies=(git cmake ninja-build gcc g++ make gettext gettext-base)

for dep in "${dependencies[@]}"; do
  if ! command -v "$dep" &> /dev/null; then
    echo "$dep is not installed. Installing..."
    sudo apt-get update
    sudo apt-get install -y "$dep"
  fi
done

# Define the Neovim repository URL and build directory
NEOVIM_REPO="https://github.com/neovim/neovim.git"
BUILD_DIR="$HOME/personal/neovim"
# Clone or update the Neovim repository
if [ -d "$BUILD_DIR" ]; then
  echo "Updating existing Neovim repository..."
  cd "$BUILD_DIR"
  git fetch --all
  git pull
else
  echo "Cloning Neovim repository..."
  git clone "$NEOVIM_REPO" "$BUILD_DIR"
  cd "$BUILD_DIR"
fi

# Checkout the latest stable release tag (not the latest branch)
LATEST_TAG=$(git tag -l --sort=-v:refname | head -n 1)
echo "Checking out the latest stable tag: $LATEST_TAG"
git checkout "$LATEST_TAG"

# Build Neovim
echo "Building Neovim..."
make CMAKE_BUILD_TYPE=RelWithDebInfo

# Install Neovim (optional)
echo "Installing Neovim (requires sudo)..."
sudo make install

# Confirm success
echo "Neovim has been built and installed successfully! Run 'nvim' to start."

