#!/bin/bash
#
# Exit script on any command failure
set -e

echo "Starting installation of development tools for JavaScript, PHP, and general development on Ubuntu..."

# Update and upgrade system packages
echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install general development tools
echo "Installing general development tools..."
sudo apt install -y \
    git \
    curl \
    wget \
    build-essential \
    software-properties-common \
    unzip \
    zip \
    tmux \
    htop \
    btop \
    tree \
    eza \             # eza — a modern replacement for ls
    zoxide            # A smarter cd command for your terminal
    python3 \
    python3-pip \
    jq \
    magic-wormhole \  # to transfer files between local machines
    pigz \            # better compression using multiprocessing threads
    age \             # encryption tool
    ripgrep \         # a fast and feature-rich (regex) grep replacement
    rclone \          # rclone is a command line program to manage files between cloud storage services
    fzf \             # a general-purpose command-line fuzzy finder
    nala \            # a package manager for Ubuntu
    fish \            # a modern and user-friendly shell
    snapd

# Install Node.js and npm (JavaScript)
echo "Installing Node.js and npm..."
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs
# Update npm to the latest version
echo "Updating npm to the latest version..."
sudo npm install -g npm@latest

# Install Yarn (JavaScript package manager)
echo "Installing Yarn..."
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update
sudo apt install -y yarn

# Install PHP and related tools
echo "Installing PHP and related tools..."
sudo apt install -y \
    php \
    php-cli \
    php-curl \
    php-mbstring \
    php-xml \
    php-zip \
    php-mysql \
    php-gd \
    composer

# Install MySQL server (optional for PHP developers)
echo "Installing MySQL server..."
sudo apt install -y mysql-server
sudo systemctl enable mysql
sudo systemctl start mysql

# Install Apache server (optional for PHP developers)
echo "Installing Apache server..."
sudo apt install -y apache2
sudo systemctl enable apache2
sudo systemctl start apache2

# Install Docker and Docker Compose
echo "Installing Docker and Docker Compose..."
sudo apt install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER

# Install common JavaScript tools
echo "Installing JavaScript tools (ESLint, Prettier, etc.)..."
sudo npm install -g \
    eslint \
    prettier \
    typescript \
    webpack \
    create-react-app \
    npm-check \
    pm2


echo "Installing Postman..."
sudo snap install postman

# Install GitHub CLI
echo "Installing GitHub CLI..."
type -p curl >/dev/null || sudo apt install curl -y
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh -y

# Clean up after installation
echo "Cleaning up..."
sudo apt autoremove -y

# Final message
echo "Development environment setup complete! Please restart your terminal or log out and log back in to apply changes."

