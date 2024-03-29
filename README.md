# Custom Ansible Playbook for macOS and Ubuntu on WSL

This is a custom script and Ansible playbook. It sets up all the tools for local web
development using Node.js.

## How to use this

### Windows

1. Install WSL
2. Install Ubuntu
3. Run the setup script from your local terminal
   ```
   /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/FullstackAcademy/developer-playbook/main/machine-setup.sh)"
   ```
4. Enter your password when prompted.

## MacOS

1. Run the setup script from your local terminal
   ```
   /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/FullstackAcademy/developer-playbook/main/machine-setup.sh)"
   ```
2. Enter your password when prompted.

This installs the following things:

- zsh (WSL Only)
- acl (WSL Only)
- git (WSL Only)
- pip for python (WSL Only)
- nvm
- Node.js
- postgresql
- Generates an ssh key in ~/.ssh/id_ed25519.pub
- Sets VS Code to be your default editor
- Configures git username, email and sets `git pull` to do a rebase
- Sets up an `open` and `wsl` alias (WSL Only)

Feel free to fork this and modify it to suit your needs or learn a bit about
how to fight with ansible.
