#!/usr/bin/env zsh

echo "\n<<< Setup Homebrew >>>\n"

if exists brew; then
    echo "Homebrew already installed."
else 
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
