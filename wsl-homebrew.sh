#!/bin/sh
sudo apt update
sudo apt upgrade -y
sudo apt install -y zsh
echo "\033[0;31m Enter your user password below. \nWhen typing, nothing will show in the terminal output. \nPress ENTER when finished.\033[0m"
chsh -s /bin/zsh
touch $HOME/.zshrc
echo "# $USER zsh settings" >> $HOME/.zshrc
echo "\033[0;31m Press ENTER when prompted, to continue installation\033[0m"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> $HOME/.zshrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
sudo apt-get install -y build-essential
brew install gcc
brew install postgresql@15
brew install gh
# /home/linuxbrew/.linuxbrew/var/postgresql@15/postgresql.conf
# /home/linuxbrew/.linuxbrew/var/postgresql@15/pg_hba.conf
echo 'export PATH="/home/linuxbrew/.linuxbrew/opt/postgresql@15/bin:$PATH"' >> $HOME/.zshrc
source $HOME/.zshrc
brew services start postgresql@15
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
echo '\nexport NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> $HOME/.zshrc
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

echo '\nexport PROMPT="%n@%m %1~ %# "' >> $HOME/.zshrc
echo 'alias open="explorer.exe"' >> $HOME/.zshrc
echo 'alias wsl="wsl.exe"' >> $HOME/.zshrc
echo 'export EDITOR="code -w"' >> $HOME/.zshrc
nvm install 18
echo "\033[0;31m Installation complete! Please open a new terminal window/tab and run the command:\ncreatedb \$USER\nto create a new postgresql database for the logged in user.\033[0m"
