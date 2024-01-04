#!/bin/sh
echo "Enter your sudo password:"
sudo apt update
sudo apt upgrade -y
sudo apt install -y software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible
ansible-galaxy collection install community.postgresql community.general
echo ""
echo -e "\033[0;31m Enter your sudo password again when prompted by BECOMES:\033[0m"
echo ""
ansible-pull -K -C jeremyTest -U https://github.com/fullstackacademy/developer-playbook.git playbook.yml
echo ""
echo "Ansible setup complete, please close your Ubuntu Terminal and open a new one."
