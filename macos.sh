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
(echo; echo 'eval "($HOMEBREW_PREFIX/bin/brew shellenv)"') >> $HOME/.zprofile
eval "($HOMEBREW_PREFIX/bin/brew shellenv)"
source ~/.zprofile
brew update
brew install ansible
ansible-galaxy collection install community.postgresql community.general
ansible-pull -K -C jeremyTest -U https://github.com/fullstackacademy/developer-playbook.git playbook.yml
echo "Ansible setup complete, close your Terminal and open a new one..."
source ~/.zshrc
brew services start postgresql@15
# Create a user through the 'postgres' psql user, with d(createdb) l(login) r(createrole) and s(superuser) permisisons - then create db for the login user
createuser -U postgres -dlrs $USER
createdb $USER
