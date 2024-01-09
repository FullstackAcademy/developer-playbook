#!/bin/sh
# This is the entry point for all users to run scripts and playbooks
# It runs the appropriate script for the user's OS
# And log commmands, STDOUT, and STDERR to a file called "fsa-machine-setup-log.ansi" (appends new logs, does not overwrite)
#
# Check OS and identify appropriate script
# Fail fast if OS is not a supported
if [ "$(/usr/bin/uname)" == "Darwin" ]; then
    MACHINE_SETUP_SCRIPT=macos.sh
    echo "\033[0;34m START logging to ~/fsa-machine-setup-log.ansi \033[0m"
    echo
    sh macos.sh 2>&1 | tee -a $HOME/fsa-machine-setup-log.ansi
elif [ "$(/usr/bin/uname)" =="Linux" ]; then
    MACHINE_SETUP_SCRIPT=wsl.sh
    echo "\033[0;34m START logging to ~/fsa-machine-setup-log.ansi \033[0m"
    echo
    sh wsl.sh 2>&1 | tee -a $HOME/fsa-machine-setup-log.ansi
else
    echo "\033[0;31m Operating system not recognized. This setup script can only be used on macOS or Linux. \033[0m"
    echo "NOTE: If you are running Windows, first install WSL and then run this script within WSL Ubuntu."
    exit
fi
