# Linux Setup Script

## Description

This repository contains a shell script designed to quickly set up a fresh Linux installation with essential tools and applications for developers and general users. The script automates the installation and configuration of various utilities, making the setup process fast and efficient.

## Features

- Installs essential packages like Git, Vim, and Tmux.
- Sets up Google Chrome, Visual Studio Code, and PyCharm Community Edition.
- Configures Oh My Zsh with useful plugins.
- Installs Docker and its dependencies.
- Includes configurations for Tmux and Vim.
- Automatically removes unnecessary packages to free up space.
- Sets up Python utilities.
- Sets up DevOps packages.
- Utilizes functions from `script_utils` submodule to streamline command execution and status reporting.

## Installation

### Prerequisite

- A fresh installation of a Debian-based Linux distribution (e.g., Ubuntu).

### Steps

1. **Clone this repository:**

   ```bash
   git clone --recurse-submodules https://github.com/aliabbasi95/linux-setup-scripts.git
   cd linux-setup-script
   ```

   **Note:** If you have already cloned the repository without --recurse-submodules, you can initialize and update the submodule with:

   ```bash
   git submodule update --init --recursive
   ```

2. **Make the setup script executable:**

   ```bash
   chmod +x setup.sh
   ```

3. **Run the setup script:**

   ```bash
   ./setup.sh
   ```

4. **Reboot the system:**

   ```bash
   sudo reboot
   ```

## DevOps Setup
To disable the installation of DevOps packages, you can comment out the following line in setup.sh:

   ```bash
   source devops_setup.sh
   ```

This line sources the devops_setup.sh script, which installs the DevOps-related tools. Commenting it out will prevent their installation.


## Python Setup
To disable the installation of Python packages, you can comment out the following line in setup.sh:

   ```bash
   source python_setup.sh
   ```

This line sources the python_setup.sh script, which installs the python tools. Commenting it out will prevent their installation.

## Using tty-clock
tty-clock is a simple terminal clock that can be launched with the following command:

   ```bash
   tty-clock -s -c
   ```
-s flag shows seconds.

-c flag centers the clock in the terminal window.

## Submodules
This repository uses a submodule for utility functions:

### script_utils: 

Contains utility functions for consistent status reporting and command execution.

These functions include:
1. print_status: Prints a message indicating the start of a command.
2. print_success: Prints a success message when a command completes successfully.
3. print_error: Prints an error message when a command fails.
4. execute_command: Executes a command, uses print_status to indicate the start, and reports success or failure using print_success or print_error.

To ensure the submodule is properly initialized, follow these steps:
   ```bash
   git submodule update --init --recursive
   ```

## Related Files
setup.sh: The main installation script.

devops_setup.sh: Contains DevOps tools that are optional for installation.

python_setup.sh: Contains python tools that are optional for installation.

## Notes

The script may require administrative privileges. Please enter your password if prompted.

Ensure that all .deb files and package source URLs are up-to-date.

If you need additional software or have questions, feel free to contact me to update the script.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.

## Contributing

Fork the repository.
Create your feature branch (git checkout -b feature/YourFeature).
Commit your changes (git commit -m 'Add some feature').
Push to the branch (git push origin feature/YourFeature).
Open a pull request.

## Contact

For any questions or comments, please contact [Ali Abbasi](mailto:info@aliabbasi.net).
