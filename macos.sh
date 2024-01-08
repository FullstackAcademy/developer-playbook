#!/bin/sh
set -e
# Fail fast if host machine is not macOS
if [ "$(/usr/bin/uname)" != "Darwin" ]; then
  echo "\033[0;31m Operating system not recognized. This script can only be run on macOS. \033[0m"
  exit
fi
#
echo "\033[0;34m START development environment setup. \033[0m"
#
echo "\033[0;34m Install Homebrew...\033[0m"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#
# Set Homebrew enviroment variables
echo "\033[0;34m Initialize Homebrew... \033[0m"
UNAME_MACHINE="$(/usr/bin/uname -m)"
if [ "${UNAME_MACHINE}" == "arm64" ]; then
  # On ARM macOS, homebrew installs to /opt/homebrew
  echo 'eval $(/opt/homebrew/bin/brew shellenv)' >>$HOME/.zshrc
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ "${UNAME_MACHINE}" == "x86_64" ]; then
  # On Intel macOS, homebrew installs to /usr/local
  echo 'eval $(/usr/local/bin/brew shellenv)' >>$HOME/.zshrc
  eval "$(/usr/local/bin/brew shellenv)"
else
  echo "\033[0;31m Chip architecture not recognized. \033[0m"
  exit
fi
#
brew update
#
echo "\033[0;34m Install Ansible... \033[0m"
brew install ansible
ansible-galaxy collection install community.postgresql community.general
echo "\033[1;34m Enter your account password again when prompted by BECOMES:\033[0m"
#
echo "\033[0;34m Run Ansible playbook... \033[0m"
# *********** NOTE: remove "-C jeremyTest" before finalizing **********
ansible-pull -K -C jeremyTest -U https://github.com/fullstackacademy/developer-playbook.git playbook.yml
#
# echo "\033[0;34m Source updated shell configuration...\033[0m"
# source $HOME/.zshrc
#
echo "\033[0;34m END development environment setup. \033[0m"
