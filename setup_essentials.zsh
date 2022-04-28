#!/usr/bin/env zsh

echo "\n<<< Install essential Applications (Dropbox, 1Password, ..) >>>\n"

pressEnter() {
    vared -p "    Press [Enter] to confirm " -c REPLY
}

brew bundle --file=Brewfile.essentials --verbose

cat <<EOF 

Dropbox:
    Login to Dropbox app.
    Wait until Dropbox folder is full synchronized to the desktop.
EOF
pressEnter

cat <<EOF 

1Password:
    Login to 1Password app.
    Activate license (see email 2019-11-29). 
    Choose 'Sync using Dropbox'.
    1Password should automatically detect 'Dropbox/Apps/1Password/1Password.ovault'.
EOF
pressEnter

cat <<EOF 

Boxcryptor:
    Login to Boxcryptor app.
    Link your Dropbox account in the Boxcryptor Preferences.
EOF
pressEnter

cat <<EOF 

Google Chrome
    Login to Google Chrome with [at] hnu.
    Do *not* use profiles for other accounts.
    Settings: Sync > Manage what you sync: Apps, Bookmarks, Extensions, Settings, Passwords.
EOF
pressEnter
