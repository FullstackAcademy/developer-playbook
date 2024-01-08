#!/bin/sh
set -e
# Fail fast if host machine is not macOS
if [ "$(/usr/bin/uname)" != "Darwin" ]; then
  echo "Operating system not recognized. This script can only be run on macOS."
  exit
fi
#
# Save terminal commands and output in a txt file.
echo "\033[0;34m START logging terminal session... \033[0m"
if ! [ -f $HOME/fsa-machine-setup-log.txt ]; then
  touch $HOME/fsa-machine-setup-log.txt
fi
script -a $HOME/fsa-machine-setup-log.txt
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
  echo "Chip architecture not recognized."
  exit
fi
#
brew update
#
echo "\033[0;34m Install Ansible... \033[0m"
brew install ansible
ansible-galaxy collection install community.postgresql community.general
echo "\033[0;31m Enter your sudo password again when prompted by BECOMES:\033[0m"
#
echo "\033[0;34m Run Ansible playbook... \033[0m"
# *********** NOTE: remove "-C jeremyTest" before finalizing **********
ansible-pull -K -C jeremyTest -U https://github.com/fullstackacademy/developer-playbook.git playbook.yml
#
echo "\033[0;34m Source updated shell configuration...\033[0m"
source $HOME/.zshrc
#
echo "\033[0;34m END development environment setup. \033[0m"
#
echo "END logging terminal session"
echo "\033[0;34m *************************************************************************** \033[0m"
exit
