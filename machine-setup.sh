#!/bin/sh
# This is the entry point for all users to run scripts and playbooks
# It runs the appropriate script for the user's OS
# And log commmands, STDOUT, and STDERR to a file called "fsa-machine-setup-log.ansi" (appends new logs, does not overwrite)
#
# Initialize text format variables
TEXT_RED="\033[0;31m"
TEXT_RED_BOLD="\033[1;31m"
TEXT_BLUE="\033[0;34m"
TEXT_CYAN="\033[0;36m"
TEXT_RESET="\033[0m"
#
# Check OS and identify appropriate script
# Fail fast if OS is not a supported
if [ "$(/usr/bin/uname)" == "Darwin" ]; then
    MACHINE_SETUP_SCRIPT=macos.sh
    echo "$TEXT_BLUE START logging to ~/fsa-machine-setup-log.ansi \n$TEXT_RESET"
    sh macos.sh 2>&1 | tee -a $HOME/fsa-machine-setup-log.ansi
elif [ "$(/usr/bin/uname)" =="Linux" ]; then
    MACHINE_SETUP_SCRIPT=wsl.sh
    echo "$TEXT_BLUE START logging to ~/fsa-machine-setup-log.ansi \n$TEXT_RESET"
    sh wsl.sh 2>&1 | tee -a $HOME/fsa-machine-setup-log.ansi
else
    echo "$TEXT_RED_BOLD Operating system not recognized \n$TEXT_RED This development environment setup script can only be run on macOS or Linux \n For Windows, first install WSL and then run this script in WSL Ubuntu $TEXT_RESET"
    exit
fi

echo "$TEXT_BLUE END logging \n$TEXT_CYAN*********************************************************************************************** $TEXT_RESET"
