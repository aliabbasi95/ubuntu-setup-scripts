#!/bin/bash

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
