#!/bin/sh
# This is the entry point for all users to run scripts and playbooks
# It runs the appropriate script for the user's OS
# And log commmands, STDOUT, and STDERR to a file called "fsa-machine-setup-log.ansi" (appends new logs, does not overwrite)
#
# Initialize text format variables
TEXT_RED="\033[0;31m"
TEXT_RED_BOLD="\033[1;31m"
TEXT_CYAN="\033[0;36m"
TEXT_RESET="\033[0m"
#
# Check OS and identify appropriate script
# Fail fast if OS is not a supported
MACHINE_SETUP_SCRIPT=""
if [ "$(/usr/bin/uname)" == "Darwin" ]; then
    MACHINE_SETUP_SCRIPT="macos.sh"
elif [ "$(/usr/bin/uname)" =="Linux" ]; then
    MACHINE_SETUP_SCRIPT="wsl.sh"
else
    echo "$TEXT_RED_BOLD Operating system not recognized \n$TEXT_RED This development environment setup script can only be run on macOS or Linux \n For Windows, first install WSL and then run this script in WSL Ubuntu $TEXT_RESET"
    exit
fi
#
echo "$TEXT_CYAN START logging to ~/fsa-machine-setup-log.ansi \n$TEXT_RESET"
/bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/FullstackAcademy/developer-playbook/jeremyTest/$MACHINE_SETUP_SCRIPT)" 2>&1 | tee -a $HOME/fsa-machine-setup-log.ansi
#
echo "$TEXT_CYAN\n END logging \n*********************************************************************************************** $TEXT_RESET"
