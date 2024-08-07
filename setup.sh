#!/bin/bash

# Update and upgrade the system
# Ensure the system is up-to-date
sudo apt update && sudo apt upgrade -y

# Install system utilities
# Basic utilities for system management and file handling
sudo apt install -y curl  # For downloading files from the web
sudo apt install -y wget  # Another tool for downloading files
sudo apt install -y gzip  # Compression utility
sudo apt install -y htop       # System monitor
sudo apt install -y tty-clock  # Clock for the terminal
sudo apt install -y iptables-persistent # Save and restore iptables rules

# Basic Development Tools
# Essential tools for software development
sudo apt install -y git           # Distributed version control system
sudo apt install -y vim           # Highly configurable text editor
sudo apt install -y tmux          # Terminal multiplexer

# Network and System Management
# Tools for managing networks and system resources
sudo apt install -y network-manager  # Manage network connections
sudo apt install -y nginx            # High-performance web server
sudo apt install -y net-tools  # Network tools including ifconfig

# Multimedia and Communication
# Applications for media playback and messaging
sudo apt install -y vlc               # Multimedia player
sudo apt install -y telegram-desktop  # Desktop messaging app

# Development Tools
# Applications and environments for software development
sudo snap install postman             # API development collaboration platform

# Database Management
# Tool for managing SQLite databases
sudo apt install -y sqlitebrowser     # SQLite database browser

# Shell and Terminal Customization
# Tools for enhancing the terminal experience
sudo apt install -y zsh             # Powerful command-line shell

# Function to install Google Chrome
install_google_chrome() {
  # Add Google's official GPG key
  wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo tee /usr/share/keyrings/google-chrome.gpg


  # Add Google Chrome's repository to the sources list
  echo "deb [signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list

  # Update package list and install Google Chrome
  sudo apt update
  sudo apt install -y google-chrome-stable
}

# Function to install Visual Studio Code
install_vscode() {
  wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
  sudo apt update
  sudo apt install -y code
}

# Function to install Docker
install_docker() {
  # Add Docker's official GPG key  
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker.gpg

  # Add Google Docker's repository to the sources list
  echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list

  # Update package list and install Docker
  sudo apt update
  sudo apt install -y docker-ce docker-ce-cli containerd.io

  sudo groupadd docker
  sudo usermod -aG docker $USER
}

# Install PostgreSQL
install_postgresql() {
  sudo apt install -y curl ca-certificates
  sudo install -d /usr/share/postgresql-common/pgdg
  sudo curl -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc --fail https://www.postgresql.org/media/keys/ACCC4CF8.asc
  sudo sh -c 'echo "deb [signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
  sudo apt update
  sudo apt -y install postgresql
}

# Install pgAdmin4
install_pgadmin4() {
  curl -fsS https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --dearmor -o /usr/share/keyrings/packages-pgadmin-org.gpg
  sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'
  sudo apt install -y pgadmin4
}

# Install Persepolis
install_persepolis() {
  # Persepolis is a download manager and GUI for aria2, offering better control over downloads
  sudo add-apt-repository -y ppa:persepolis/ppa
  sudo apt update
  sudo apt install -y persepolis
}

# Install Oh My Zsh
install_oh_my_zsh() {
  curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o install.sh
  sh install.sh --unattended
}

# Configure environment
configure_global_environment() {
  # Configure Tmux with basic settings for a better terminal experience
  CONFIG_FILE=/etc/profile.d/custom.sh
  sudo touch $CONFIG_FILE
  sudo chmod 644 $CONFIG_FILE

  # Add general PATH entries
  echo 'export PATH=$PATH:/usr/local/bin' | sudo tee -a $CONFIG_FILE
  echo 'export PATH=/usr/bin:/bin:/usr/sbin:/sbin:$PATH' | sudo tee -a $CONFIG_FILE
  echo 'alias py=python3' | sudo tee -a $CONFIG_FILE
  echo 'alias python=python3' | sudo tee -a $CONFIG_FILE
  LOCAL_BIN_PATH="$HOME/.local/bin"
  echo "export PATH=\"$LOCAL_BIN_PATH:\$PATH\"" | sudo tee -a $CONFIG_FILE
  sudo bash -c "source /etc/profile.d/custom.sh"
}

# Configure tmux
configure_tmux() {
  cat <<EOT >> ~/.tmux.conf
set -g mouse on
bind-key c new-window
bind-key v split-window -h
bind-key s split-window -v
EOT
}

# Configure Vim
configure_vim() {
  # Configure Vim with line numbers and syntax highlighting
  cat <<EOT >> ~/.vimrc
set number
syntax on
EOT
}

# Configure Oh My Zsh
configure_oh_my_zsh() {
  # Add useful plugins to Oh My Zsh configuration
  ZSHRC=~/.zshrc
  echo "plugins=(git python vscode postgres docker)" >> $ZSHRC
  echo 'export PATH=$PATH:/usr/local/bin' | sudo tee -a $ZSHRC
  echo 'export PATH=/usr/bin:/bin:/usr/sbin:/sbin:$PATH' | sudo tee -a $ZSHRC
  echo 'alias py=python3' | sudo tee -a $ZSHRC
  echo 'alias python=python3' | sudo tee -a $ZSHRC
  LOCAL_BIN_PATH="$HOME/.local/bin"
  echo "export PATH=\"$LOCAL_BIN_PATH:\$PATH\"" | sudo tee -a $ZSHRC
  chsh -s $(which zsh)
}

# Install all applications and configurations
install_google_chrome
install_vscode
install_docker
install_persepolis
install_postgresql
install_pgAdmin4
install_oh_my_zsh
configure_global_environment
configure_tmux
configure_vim
configure_oh_my_zsh

# Import DevOps setup script
sudo bash -c "source devops_setup.sh"

# Import Python setup script
sudo bash -c "source python_setup.sh"

# Clean up
sudo apt autoremove -y

# Final message
echo "Setup complete! Please reboot your system."
