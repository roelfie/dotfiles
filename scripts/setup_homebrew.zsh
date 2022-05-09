#!/usr/bin/env zsh

echo "\n<<< Setup Homebrew >>>\n"

if exists brew; then
    echo "Homebrew already installed."
else 
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Problem in subsequent script: "./setup_essentials.zsh:9: command not found: brew"
    # Attempt to fix (copied from 'next steps' section in output of the brew installation)
    # TODO need better solution (not idempotent & subject to change in newer homebrew versions?)
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/roelfie/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
