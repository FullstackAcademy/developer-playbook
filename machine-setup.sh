#!/bin/sh
# This is the entry point for all users to run scripts and playbooks
# It runs the appropriate script for the user's OS
# And log commmands, STDOUT, and STDERR to a file called "fsa-machine-setup-log.ansi" (appends new logs, does not overwrite)
#
# Initialize text format variables
TEXT_RED="\033[0;31m"
TEXT_RED_BOLD="\033[1;31m"
TEXT_BLUE="\033[0;34m"
TEXT_BLUE_BOLD="\033[1;34m"
TEXT_CYAN="\033[0;36m"
TEXT_RESET="\033[0m"
#
# Check OS and identify appropriate script
# Fail if OS is not a supported
MACHINE_SETUP_SCRIPT=""
if [ "$(/usr/bin/uname)" == "Darwin" ]; then
    MACHINE_SETUP_SCRIPT="macos.sh"
elif [ "$(/usr/bin/uname)" = "Linux" ]; then
    MACHINE_SETUP_SCRIPT="wsl.sh"
else
    echo "$TEXT_RED_BOLD Operating system not recognized \n$TEXT_RED This development environment setup script can only be run on macOS or Linux \n For Windows, first install WSL and then run this script in WSL Ubuntu $TEXT_RESET"
    exit
fi
## Run setup script for the identified OS with logging
echo "$TEXT_CYAN START logging to ~/fsa-machine-setup-log.ansi \n$TEXT_RESET"
/bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/FullstackAcademy/developer-playbook/main/$MACHINE_SETUP_SCRIPT)" 2>&1 | tee -a $HOME/fsa-machine-setup-log.ansi
#
# Execute updated zsh config file for macOS users
if [ "$(/usr/bin/uname)" == "Darwin" ]; then
    source ~/.zprofile
fi
# Run Ansible playbook for all users
echo "$TEXT_BLUE\n Run Ansible playbook... $TEXT_RESET"
echo "$TEXT_BLUE_BOLD\n Enter your account password when prompted by BECOME $TEXT_RESET"
echo "$TEXT_BLUE  If there is no output, your password was accepted and the playbook is running. $TEXT_RESET"
echo "$TEXT_BLUE  Leave this terminal window open until all installations are complete. $TEXT_RESET"
ansible-pull -K -C main -U https://github.com/fullstackacademy/developer-playbook.git playbook.yml
#
echo "$TEXT_BLUE_BOLD END development environment setup. $TEXT_RESET"
echo "\n Please close your terminal window and open a new one.\n"
echo "$TEXT_CYAN\END logging \n*********************************************************************************************** $TEXT_RESET"
