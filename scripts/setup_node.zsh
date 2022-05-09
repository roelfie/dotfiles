#!/usr/bin/env zsh

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

# Install global NPM packages
npm install --global typescript
npm install --global json-server
npm install --global http-server
npm install --global trash-cli

echo "Global NPM packages installed:"
npm list --global --depth=0


