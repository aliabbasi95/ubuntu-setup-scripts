#!/bin/bash

###################################################################
#Script Name    : Install linux utilities
#Description    : Automates the installation of essential utilities
#Author         : Ali Abbasi
#Email          : info@aliabbasi.net
###################################################################

# Display banner
echo -e "${YELLOW}******************************************************************************"
echo -e "${YELLOW}**                                                                          **"
echo -e "${YELLOW}**                         Install linux utilities                          **"
echo -e "${YELLOW}**            Automates the installation of essential utilities             **"
echo -e "${YELLOW}**                                                                          **"
echo -e "${YELLOW}**                               Ali Abbasi                                 **"
echo -e "${YELLOW}**                           info@aliabbasi.net                             **"
echo -e "${YELLOW}******************************************************************************"

# Determine the path to the script_utils.sh
SCRIPT_UTILS_PATH="submodules/script_utils/script_utils.sh"

# Import functions and variables from script_utils.sh if the file exists
if [ -f "$SCRIPT_UTILS_PATH" ]; then
    source "$SCRIPT_UTILS_PATH"
else
    echo "Error: script_utils.sh not found at $SCRIPT_UTILS_PATH"
    exit 1
fi

# Update and upgrade the system
print_status "Update and upgrade the system..."
execute_command "sudo apt update" "Updating apt repository"
execute_command "sudo apt upgrade -y" "Upgrading system packages"

# Install system utilities
print_status "Installing system utilities..."
# Installing curl
execute_command "sudo apt install -y curl" "Installing curl" # For downloading files from the web
# Installing wget
execute_command "sudo apt install -y wget" "Installing wget" # Another tool for downloading files
# Installing gzip
execute_command "sudo apt install -y gzip" "Installing gzip" # Compression utility
# Installing htop
execute_command "sudo apt install -y htop" "Installing htop" # System monitor
# Installing tty-clock
execute_command "sudo apt install -y tty-clock" "Installing tty-clock" # Clock for the terminal
# Installing iptables
execute_command "sudo apt install -y iptables-persistent" "Installing iptables-persistent" # Save and restore iptables rules

# Install Basic Development Tools
print_status "Installing development tools..."
# Installing Git
execute_command "sudo apt install -y git" "Installing Git"    # Distributed version control system
# Installing Vim
execute_command "sudo apt install -y vim" "Installing Vim"    # Highly configurable text editor
# Installing Tmux
execute_command "sudo apt install -y tmux" "Installing Tmux"  # Terminal multiplexer

# Network and System Management
print_status "Installing network and system management tools..."
# Installing network-manager
execute_command "sudo apt install -y network-manager" "Installing Network Manager"  # Manage network connections
# Installing nginx
execute_command "sudo apt install -y nginx" "Installing Nginx"                      # High-performance web server
# Installing net-tools
execute_command "sudo apt install -y net-tools" "Installing Net Tools"              # Network tools including ifconfig


# Multimedia and Communication
# # Applications for media playback and messaging
print_status "Installing multimedia and communication tools..."
execute_command "sudo apt install -y vlc" "Installing VLC"                          # Multimedia player
execute_command "sudo snap install telegram-desktop" "Installing Telegram Desktop"  # Desktop messaging app

# Development Tools
# Applications and environments for software development
print_status "Installing additional development tools..."
execute_command "sudo snap install postman" "Installing Postman"  # API development collaboration platform

# Database Management
# Tool for managing SQLite databases
print_status "Installing database management tools..."
execute_command "sudo apt install -y sqlitebrowser" "Installing SQLite Browser" # SQLite database browser

# Shell and Terminal Customization
# Tools for enhancing the terminal experience
print_status "Installing shell and terminal customization tools..."
execute_command "sudo apt install -y zsh" "Installing Zsh"  # Powerful command-line shell

# Function to install Google Chrome
install_google_chrome() {
    # Add Google's official GPG key
    execute_command "wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/google-linux-signing-key.gpg > /dev/null" "Adding Google Chrome GPG key"

    # Add Google Chrome's repository to the sources list
    execute_command "echo \"deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main\" | sudo tee /etc/apt/sources.list.d/google-chrome.list" "Adding Google Chrome repository"

    # Update package list and install Google Chrome
    execute_command "sudo apt update && sudo apt install -y google-chrome-stable" "Installing Google Chrome"
}

# # Function to install Visual Studio Code
install_vscode() {
    # Add Microsoft's official GPG key for Visual Studio Code
    execute_command "wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc > /dev/null" "Adding Visual Studio Code GPG key"

    # Add Visual Studio Code's repository to the sources list
    execute_command "sudo add-apt-repository \"deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main\"" "Adding Visual Studio Code repository"

    # Update package list and install Visual Studio Code
    execute_command "sudo apt update && sudo apt install -y code" "Installing Visual Studio Code"
}

# Function to install Docker
install_docker() {
    # Add Docker's official GPG key  
    execute_command "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker.gpg" "Adding Docker GPG key"

    # Add Docker's repository to the sources list
    execute_command "echo \"deb [arch=amd64 signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\" | sudo tee /etc/apt/sources.list.d/docker.list" "Adding Docker repository"

    # Update package list and install Docker
    execute_command "sudo apt update && sudo apt install -y docker-ce docker-ce-cli containerd.io" "Installing Docker"
    
    # Adding user to Docker group
    execute_command "sudo groupadd docker && sudo usermod -aG docker \$USER" "Adding user to Docker group"
}

# Install PostgreSQL
install_postgresql() {
    # Install dependencies for PostgreSQL
    execute_command "sudo apt install -y curl ca-certificates" "Installing curl and ca-certificates"

    # Create directory for PostgreSQL keys
    execute_command "sudo install -d /usr/share/postgresql-common/pgdg" "Creating directory for PostgreSQL keys"

    # Download and add PostgreSQL's official GPG key
    execute_command "sudo curl -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc --fail https://www.postgresql.org/media/keys/ACCC4CF8.asc" "Downloading PostgreSQL GPG key"

    # Add PostgreSQL's repository to the sources list
    execute_command "sudo sh -c 'echo \"deb [signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main\" > /etc/apt/sources.list.d/pgdg.list'" "Adding PostgreSQL repository"

    # Update package list and install PostgreSQL
    execute_command "sudo apt update && sudo apt -y install postgresql" "Installing PostgreSQL"
}

# Install pgAdmin4
install_pgadmin4() {
    # Add pgAdmin4's official GPG key
    execute_command "curl -fsS https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --dearmor -o /usr/share/keyrings/packages-pgadmin-org.gpg" "Adding pgAdmin4 GPG key"
    
    # Add pgAdmin4's repository to the sources list
    execute_command "sudo sh -c 'echo \"deb [signed-by=/usr/share/keyrings/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main\" > /etc/apt/sources.list.d/pgadmin4.list && apt update'" "Adding pgAdmin4 repository"

    # Update package list and install pgAdmin4
    execute_command "sudo apt install -y pgadmin4" "Installing pgAdmin4"
}

# Function to install Persepolis Download Manager
install_persepolis() {
    # Add Persepolis PPA (Personal Package Archive) to the system
    execute_command "sudo add-apt-repository -y ppa:persepolis/ppa" "Adding Persepolis PPA"

    # Update package list and install Persepolis
    execute_command "sudo apt update && sudo apt install -y persepolis" "Installing Persepolis"
}

# Install Oh My Zsh
install_oh_my_zsh() {
    # Download the Oh My Zsh installer script
    execute_command "curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o install.sh" "Downloading Oh My Zsh installer"
    # Run the installer script in unattended mode
    execute_command "sh install.sh --unattended" "Installing Oh My Zsh"
    # Remove the installer file after installation
    execute_command "rm -f install.sh" "Removing Oh My Zsh installer"
}

# Function to configure global environment settings
configure_global_environment() {
    print_status "Configuring global environment..."
    
    # Define the path for the custom environment file
    CONFIG_FILE=/etc/profile.d/custom.sh
    
    # Create the custom.sh file for environment variables and aliases if it doesn't exist
    if [ ! -f "$CONFIG_FILE" ]; then
        execute_command "sudo touch $CONFIG_FILE" "Creating custom.sh"
    fi
    
    # Set the appropriate permissions for the custom.sh file
    execute_command "sudo chmod 644 $CONFIG_FILE" "Setting permissions for custom.sh"
    
    # Add /usr/local/bin to the PATH variable
    safe_append_to_file 'export PATH=$PATH:/usr/local/bin' "$CONFIG_FILE" "Adding /usr/local/bin to PATH"
    
    # Add system binaries to the PATH variable
    safe_append_to_file 'export PATH=/usr/bin:/bin:/usr/sbin:/sbin:$PATH' "$CONFIG_FILE" "Adding system binaries to PATH"
    
    # Create alias for Python 3 as 'py'
    safe_append_to_file 'alias py=python3' "$CONFIG_FILE" "Adding alias for Python 3"
    
    # Create alias for Python 3 as 'python'
    safe_append_to_file 'alias python=python3' "$CONFIG_FILE" "Adding alias for Python"
    
    # Define the path for local binaries
    LOCAL_BIN_PATH="$HOME/.local/bin"
    
    # Add the LOCAL_BIN_PATH to the PATH variable
    safe_append_to_file "export PATH=\"$LOCAL_BIN_PATH:\$PATH\"" "$CONFIG_FILE" "Adding LOCAL_BIN_PATH to environment"
    
    # Source the custom.sh file in .bashrc to load the changes
    safe_append_to_file 'source /etc/profile.d/custom.sh' "$HOME/.bashrc" "Sourcing custom.sh in .bashrc"
}


# Configure tmux
configure_tmux() {
    local tmux_conf="$HOME/.tmux.conf"
    print_status "Configuring tmux..."

    safe_append_to_file "set -g mouse on" "$tmux_conf" "Enable mouse support in tmux"
    safe_append_to_file "bind-key c new-window" "$tmux_conf" "Bind 'c' to create a new window in tmux"
    safe_append_to_file "bind-key v split-window -h" "$tmux_conf" "Bind 'v' to split window horizontally in tmux"
    safe_append_to_file "bind-key s split-window -v" "$tmux_conf" "Bind 's' to split window vertically in tmux"
}

# Configure Vim
configure_vim() {
    local vimrc="$HOME/.vimrc"
    print_status "Configuring Vim..."

    safe_append_to_file "set number" "$vimrc" "Enable line numbers in Vim"
    safe_append_to_file "syntax on" "$vimrc" "Enable syntax highlighting in Vim"
}

# Configure Oh My Zsh
configure_oh_my_zsh() {
    local ZSHRC="$HOME/.zshrc"
    print_status "Configuring Oh My Zsh..."

    safe_append_to_file "plugins=(git python vscode postgres docker)" "$ZSHRC" "Adding useful plugins to Oh My Zsh"
    safe_append_to_file "export PATH=\$PATH:/usr/local/bin" "$ZSHRC" "Adding /usr/local/bin to PATH in zshrc"
    safe_append_to_file "export PATH=/usr/bin:/bin:/usr/sbin:/sbin:\$PATH" "$ZSHRC" "Adding system binaries to PATH in zshrc"
    safe_append_to_file "alias py=python3" "$ZSHRC" "Adding alias for Python 3 in zshrc"
    safe_append_to_file "alias python=python3" "$ZSHRC" "Adding alias for Python in zshrc"

    local LOCAL_BIN_PATH="$HOME/.local/bin"
    safe_append_to_file "export PATH=\"$LOCAL_BIN_PATH:\$PATH\"" "$ZSHRC" "Adding LOCAL_BIN_PATH to zshrc"

    execute_command "chsh -s $(which zsh)" "Changing shell to zsh"
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
print_status "Clean up..."
execute_command "apt autoremove -y" "Clean up"

# Final message
echo "Setup complete! Please reboot your system."
