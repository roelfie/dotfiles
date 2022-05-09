#!/usr/bin/env zsh

echo "\n<<< Install essential Applications (Dropbox, 1Password, Boxcryptor, Chrome) >>>\n"

instruction() {
    print "\n\n$1"
    vared -p "    Press [Enter] when finished. " -c REPLY
}

brew bundle --file=Brewfile.essentials --verbose

instruction "Dropbox:
    Login to Dropbox app.
    Wait until Dropbox folder is full synchronized to the desktop."

instruction "1Password:
    Open 1Password.
    Register 1Password; a backup of my 1Password 7 standalone license can be found here:
      - in 1Password under Software Licenses
      - in Dropbox folder 'prive/software'
    Choose 'Sync using Dropbox'.
    1Password should automatically detect 'Dropbox/Apps/1Password/1Password.ovault'."

instruction "Boxcryptor:
    Login to Boxcryptor app.
    Link your Dropbox account in the Boxcryptor Preferences."

instruction "Google Chrome
    Login to Google Chrome with [at] hnu.
    Do *not* use profiles for other accounts.
    Settings: Sync > Manage what you sync: Apps, Bookmarks, Extensions, Settings, Open Tabs, Passwords."
