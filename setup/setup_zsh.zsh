#!/usr/bin/env zsh

echo "\n<<< Setup ZSH >>>\n"

# Installation of zsh unnecessary; it's in the Brewfile.

# https://stackoverflow.com/a/4749368/1341838
# Add the homebrew managed zsh shell to the list of default shells.
if grep -Fxq "$HOMEBREW_PREFIX/bin/zsh" '/etc/shells'; then
  echo "$HOMEBREW_PREFIX/bin/zsh already exists in /etc/shells"
else
  echo "Enter superuser (sudo) password to edit /etc/shells"
  echo "$HOMEBREW_PREFIX/bin/zsh" | sudo tee -a '/etc/shells' >/dev/null
fi


# Make the homebrew managed zsh shell the default shell.
if [ "$SHELL" = "$HOMEBREW_PREFIX/bin/zsh" ]; then
  echo 'SHELL is already $HOMEBREW_PREFIX/bin/zsh'
else
  echo "Enter user password to change login shell"
  chsh -s "$HOMEBREW_PREFIX/bin/zsh"
fi


# Make sh symlink to zsh instead of bash (optional?)
if sh --version | grep -q zsh; then
  echo '/private/var/select/sh already linked to /bin/zsh'
else
  echo "Enter superuser (sudo) password to symlink sh to zsh"
  sudo ln -sfv /bin/zsh /private/var/select/sh
  # I'd like for this to work instead.
  # sudo ln -sfv /usr/local/bin/zsh /private/var/select/sh
fi


echo "Enter superuser (sudo) password."
echo "$HOMEBREW_PREFIX/bin/zsh" | sudo tee -a '/etc/shells'

echo "\nThe default login shell for the current user "
echo "should now be set to $HOMEBREW_PREFIX/bin/zsh."
echo "Please double check this in the System Preferences: "
echo "  [ Users & Groups > Advanced Options > Login Shell ]"

open /System/Library/PreferencePanes/Accounts.prefPane

vared -p "Then press [Enter] to continue." -c IGNORE_ME
