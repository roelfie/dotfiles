#!/usr/bin/env zsh

echo "\n<<< Setup Homebrew >>>\n"

if exists brew; then
    echo "Homebrew already installed."
else 
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # the following steps are copied from the 'next steps' in the output of the brew  installation
    # TODO fix (not idempotent & subject to change in newer homebrew versions?)
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/roelfie/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
