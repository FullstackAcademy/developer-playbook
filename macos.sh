#!/bin/sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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
(echo; echo 'eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"') >> $HOME/.zshrc
echo "export HOMEBREW_PREFIX=$HOMEBREW_PREFIX" >> $HOME/.zshrc
eval "($HOMEBREW_PREFIX/bin/brew shellenv)"
source $HOME/.zshrc
brew update
brew install ansible
ansible-galaxy collection install community.postgresql community.general
echo -e "\033[0;31m Enter your sudo password again when prompted by BECOMES:\033[0m"
ansible-pull -K -C jeremyTest -U https://github.com/fullstackacademy/developer-playbook.git playbook.yml
echo "Ansible setup complete, close your Terminal and open a new one..."
source $HOME/.zshrc
brew services start postgresql@15
# brew services restart postgresql@15
# Create a user through the 'postgres' psql user, with d(createdb) l(login) r(createrole) and s(superuser) permisisons - then create db for the login user
# createuser -U postgres -dlrs $USER
createdb $USER
