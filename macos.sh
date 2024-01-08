#!/bin/sh
echo "\033[0;34m START development environment setup. \033[0m"

echo "\033[0;34m Install Homebrew...\033[0m"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "\033[0;34m Initialize Homebrew... \033[0m"
UNAME_MACHINE="$(/usr/bin/uname -m)"
if [[ "${UNAME_MACHINE}" == "arm64" ]]
then
  # On ARM macOS, this script installs to /opt/homebrew only
  HOMEBREW_PREFIX="/opt/homebrew"
else
  # On Intel macOS, this script installs to /usr/local only
  HOMEBREW_PREFIX="/usr/local"
fi
# Next two lines - Run the homebrew "brew" command install
echo "export HOMEBREW_PREFIX=$HOMEBREW_PREFIX" >> $HOME/.zshrc
(echo; echo 'eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"') >> $HOME/.zshrc
eval "($HOMEBREW_PREFIX/bin/brew shellenv)"
source $HOME/.zshrc
brew update

echo "\033[0;34m Install Ansible... \033[0m"
brew install ansible
ansible-galaxy collection install community.postgresql community.general
echo "\033[0;31m Enter your sudo password again when prompted by BECOMES:\033[0m"

echo "\033[0;34m Run Ansible playbook... \033[0m"
# NOTE: remove "-C jeremyTest" before finalizing
ansible-pull -K -C jeremyTest -U https://github.com/fullstackacademy/developer-playbook.git playbook.yml

echo "\033[0;34m Source updated shell configuration...\033[0m"
source $HOME/.zshrc
# brew services start postgresql@15
# brew services restart postgresql@15
# Create a user through the 'postgres' psql user, with d(createdb) l(login) r(createrole) and s(superuser) permisisons - then create db for the login user
# createuser -U postgres -dlrs $USER
# createdb $USER
echo "\033[0;34m END development environment setup. \033[0m"
