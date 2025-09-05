#!/usr/bin/env zsh

echo "\n<<< Install essential Applications (Dropbox, 1Password, Chrome) >>>\n"

instruction() {
    print "\n\n$1"
    vared -p "    Press [Enter] when finished. " -c REPLY
}

brew bundle --file=Brewfile.essentials --verbose

instruction "Dropbox:
    Login to Dropbox app.
    Wait until Dropbox folder is full synchronized to the desktop."

instruction "1Password:
    1Password successfully installed. 
    I don't use the standalone license anymore. 
    I use the cloud version."

instruction "Google Chrome
    Login to Google Chrome with [at] hnu (phone needed for 2FA).
    Do *not* use profiles for other accounts.
    Settings: Sync > Manage what you sync: Apps, Bookmarks, Extensions, Settings, Open Tabs, Passwords."
