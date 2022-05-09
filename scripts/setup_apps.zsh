#!/usr/bin/env zsh

echo "\n<<< Install all Homebrew Packages, Casks and Applications >>>\n"

echo "Please log in to the AppStore."
vared -p "Then press [Enter] to continue. " -c REPLY

brew bundle --verbose

echo "\nThe following apps were not installed with homebrew / mas:"
echo " - Aeon Timeline            (not purchased via AppStore)"
echo " - Squash 3                 (not purchased via AppStore)"
echo " - iDMSS Plus (and DMSS?)   (not available in the AppStore)"
echo "Download & install them manually if needed.\n\n"
vared -p "Press [Enter] to continue. " -c REPLY
