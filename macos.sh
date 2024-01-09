#!/bin/sh
#
echo "\033[0;34m START development environment setup \033[0m"
echo
echo "\033[0;34m Install Homebrew...\033[0m"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#
# Check if Homebrew is installed
if [ ! -f "$HOMEBREW_PREFIX/bin/brew" ]; then
  echo "\033[0;31m Homebrew is not installed. \033[0m"
  exit
fi
#
# Set Homebrew enviroment variables
echo "\033[0;34m Initialize Homebrew... \033[0m"
UNAME_MACHINE="$(/usr/bin/uname -m)"
HOMEBREW_PREFIX=""
HOMEBREW_INIT=""
if [ "${UNAME_MACHINE}" == "arm64" ]; then
  # On ARM macOS, homebrew installs to /opt/homebrew
  HOMEBREW_PREFIX='/opt/homebrew/'
  HOMEBREW_INIT='eval $(/opt/homebrew/bin/brew shellenv)'

elif [ "${UNAME_MACHINE}" == "x86_64" ]; then
  # On Intel macOS, homebrew installs to /usr/local
  HOMEBREW_PREFIX='/usr/local/'
  HOMEBREW_INIT='eval $(/usr/local/bin/brew shellenv)'
else
  echo "\033[0;31m Chip architecture not recognized. \033[0m"
  exit
fi
#
# Check if .zprofile exists and includes the Homebrew initialization script
if [[ -f $HOME/.zprofile && $(grep -c "$HOMEBREW_INIT" $HOME/.zprofile) != 0 ]]; then
  echo "\033[0;34m Homebrew is already initialized. \033[0m"
else
  # if not, add initialization script to .zprofile and run it in the current shell
  echo $HOMEBREW_INIT >>$HOME/.zprofile
  eval $HOMEBREW_INIT
fi
#
brew update
#
echo "\033[0;34m Install Ansible... \033[0m"
brew install ansible
ansible-galaxy collection install community.postgresql community.general
#
# Check if ansible is installed
#
if [ ! -f "$HOMEBREW_PREFIX/bin/ansible" ]; then
  echo "\033[0;31m Ansible is not installed. \033[0m"
  exit
fi
#
echo "\033[0;34m Run Ansible playbook... \033[0m"
echo
echo "\033[1;34m Enter your account password again when prompted by BECOMES \033[0m"
echo "\033[0;34m  If there is no output, your password was accepted and the playbook is running. \033[0m"
echo "\033[0;34m  Leave this terminal window open until all installations are complete. \033[0m"
# *********** NOTE: remove "-C jeremyTest" before finalizing **********
ansible-pull -K -C jeremyTest -U https://github.com/fullstackacademy/developer-playbook.git playbook.yml
#
# echo "\033[0;34m Source updated shell configuration...\033[0m"
# source $HOME/.zshrc
#
echo "\033[0;34m END development environment setup. \033[0m"
echo "\033[0;34m *********************************************************************************************** \033[0m"
echo "\033[0;34m END logging. \033[0m"
