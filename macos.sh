#!/bin/sh
#
# Initialize text format variables
TEXT_RED="\033[0;31m"
TEXT_BLUE="\033[0;34m"
TEXT_BLUE_BOLD="\033[1;34m"
TEXT_RESET="\033[0m"
#
echo "$TEXT_BLUE_BOLD START development environment setup $TEXT_RESET"
echo
echo "$TEXT_BLUE Install Homebrew...$TEXT_RESET"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#
# Check if Homebrew is installed
if [ ! -f "$HOMEBREW_PREFIX/bin/brew" ]; then
  echo "\033[0;31m Homebrew is not installed. \033[0m"
  exit
fi
#
# Set Homebrew enviroment variables
echo "$TEXT_BLUE Initialize Homebrew... $TEXT_RESET"
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
  echo "$TEXT_RED Chip architecture not recognized. $TEXT_RESET"
  exit
fi
#
# Check if .zprofile exists and includes the Homebrew initialization script
if [[ -f $HOME/.zprofile && $(grep -c "$HOMEBREW_INIT" $HOME/.zprofile) != 0 ]]; then
  echo "$TEXT_BLUE\n Homebrew was already initialized $TEXT_RESET"
else
  # if not, add initialization script to .zprofile and run it in the current shell
  echo $HOMEBREW_INIT >>$HOME/.zprofile
  eval $HOMEBREW_INIT
  echo "$TEXT_BLUE\n Homebrew initialization complete $TEXT_RESET"
fi
#
brew update
#
echo "$TEXT_BLUE Install Ansible... $TEXT_RESET"
brew install ansible
ansible-galaxy collection install community.postgresql community.general
#
# Check if ansible is installed
#
if [ ! -f "$HOMEBREW_PREFIX/bin/ansible" ]; then
  echo "$TEXT_RED Ansible is not installed. $TEXT_RESET"
  exit
fi
#
echo "$TEXT_BLUE Run Ansible playbook... $TEXT_RESET"
echo
echo "$TEXT_BLUE_BOLD Enter your account password again when prompted by BECOMES $TEXT_RESET"
echo "$TEXT_BLUE  If there is no output, your password was accepted and the playbook is running. $TEXT_RESET"
echo "$TEXT_BLUE  Leave this terminal window open until all installations are complete. $TEXT_RESET"
# *********** NOTE: remove "-C jeremyTest" before finalizing **********
ansible-pull -K -C jeremyTest -U https://github.com/fullstackacademy/developer-playbook.git playbook.yml
#
# echo "$TEXT_BLUE Source updated shell configuration...$TEXT_RESET"
# source $HOME/.zshrc
#
echo "$TEXT_BLUE_BOLD END development environment setup. $TEXT_RESET"
