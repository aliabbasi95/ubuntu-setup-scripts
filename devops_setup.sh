#!/bin/bash

###################################################################
#Script Name    : Install DevOps utilities
#Description    : Automates the installation DevOps utilities
#Author       	: Ali Abbasi
#Email         	: info@aliabbasi.net
###################################################################

# Determine the path to the script_utils.sh
SCRIPT_UTILS_PATH="submodules/script_utils.sh"

# Import functions and variables from script_utils.sh if the file exists
if [ -f "$SCRIPT_UTILS_PATH" ]; then
    source "$SCRIPT_UTILS_PATH"
else
    echo "Error: script_utils.sh not found at $SCRIPT_UTILS_PATH"
    exit 1
fi

# DevOps Packages
# Tools and platforms for DevOps automation and management

print_status "DevOps tools start..."

# Install Packer
print_status "Installing Packer..."
execute_command "sudo apt install -y packer" "Installing packer"  # Packer is a tool for building identical machine images for multiple platforms.

# Install Vagrant
print_status "Installing vagrant..."
execute_command "sudo apt install -y vagrant" "Installing vagrant"  # Vagrant is a tool for building and managing virtualized development environments.

# Install Ansible
print_status "Installing ansible..."
execute_command "sudo apt install -y ansible" "Installing packer"  # Ansible is an open-source software provisioning, configuration management, and application-deployment tool.

print_success "DevOps tools setup completed successfully!"
