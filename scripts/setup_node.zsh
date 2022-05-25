#!/usr/bin/env zsh
# 
# Install 'n' (node version manager)
# & install all global npm packages from a backup file (using backup-global).
# 
# If backup-global ever stops working, look here for inspiration:
# https://stackoverflow.com/questions/32628351/export-import-npm-global-packages

echo "\n<<< Setup Node >>>\n"

# Node versions are managed with 'n' which is in the Brewfile.
# See zshrc for N_PREFIX and addition to the PATH.

if exists node; then
    echo "Node $(node --version) and npm $(npm --version) already installed."
else 
    echo "Installing Node and NPM with n."
    n lts
    n latest
fi

npm install --global backup-global

# Install global NPM packages (from bck file instead of manual 'npm install --global' statements)
# Bookkeeper uses the same 'backup-global' to restore node packages from this backup file.
# TODO potential issue on first run: ~/.n/bin/backup-global may not be part of the  PATH yet?
backup-global install --no-version --no-yarn --input $HOME/.dotfiles/backup/npm.global.txt

echo "Global NPM packages installed:"
npm list --global --depth=0


