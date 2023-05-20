#!/usr/bin/env zsh

echo "\n<<< Install all Homebrew Packages, Casks and Applications >>>\n"

# AppStore login instruction removed. You're automatically logged in 
# with the Apple ID that you authenticated with earlier in the macOS setup process.

brew bundle --verbose

echo "\nThe following apps were not installed with homebrew / mas:"
echo " - Aeon Timeline            (not purchased via AppStore)"
echo " - Squash 3                 (not purchased via AppStore)"
echo " - iDMSS Plus (and DMSS?)   (not available in the AppStore)"
echo " - albelli                  (not available in the AppStore)"
echo "Download & install them manually if needed.\n\n"
vared -p "Press [Enter] to continue. " -c REPLY
