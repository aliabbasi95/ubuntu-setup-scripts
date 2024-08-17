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

# Install Packer
# Packer is a tool for building identical machine images for multiple platforms.
sudo apt install -y packer

# Install Vagrant
# Vagrant is a tool for building and managing virtualized development environments.
sudo apt install -y vagrant

# Install Ansible
# Ansible is an open-source software provisioning, configuration management, and application-deployment tool.
sudo apt install -y ansible
