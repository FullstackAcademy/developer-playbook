#!/bin/sh

# Initialize text format variables
TEXT_RED="\033[0;31m"
TEXT_RED_BOLD="\033[1;31m"
TEXT_BLUE="\033[0;34m"
TEXT_BLUE_BOLD="\033[1;34m"
TEXT_CYAN="\033[0;36m"
TEXT_RESET="\033[0m"
#
echo "$TEXT_BLUE_BOLD START development environment setup $TEXT_RESET"
echo
#

echo "$TEXT_BLUE_BOLD Enter your Ubuntu password when prompted $TEXT_RESET"
echo
echo "$TEXT_BLUE Update apt package manager... $TEXT_RESET"
sudo apt update
#
echo "$TEXT_BLUE Upgrade apt package manager... $TEXT_RESET"
sudo apt upgrade -y
#
echo "$TEXT_BLUE Install Ansible... $TEXT_RESET"
sudo apt install -y software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible
ansible-galaxy collection install community.postgresql community.general
