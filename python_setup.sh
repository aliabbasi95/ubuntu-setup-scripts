#!/bin/bash

###################################################################
#Script Name    : Install pyhton utilities
#Description	  : Automates the installation python utilities
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

install_python_utilities() {
  # Install Python utilities
  sudo apt install -y python3-pip       # Python package installer
  sudo apt install -y virtualenv        # Virtual environment tool for Python
}

install_django() {
  # Install Django
  pip3 install Django==4.2.7            # Specific version of Django
}

# Install all applications and configurations
install_python_utilities
install_django

# Install PyCharm Community Edition
sudo snap install pycharm-community --classic # Python IDE
