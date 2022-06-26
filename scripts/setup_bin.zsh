#!/usr/bin/env zsh
#
# My personal scripts are stored in ~/bin/personal -> .dotfiles/bin.
# Client scripts are not stored in Github (confidential).
# They are stored in ~/Dropbox/bin/work/<CLIENT>.
# This script creates symlinks ~/bin/work/<CLIENT> -> ~/Dropbox/bin/work/<CLIENT>.
#
# NB: .zshrc adds each ~/bin/work/<CLIENT> to the $PATH.

mkdir -p /Users/roelfie/temp/work

WORK_BIN_SOURCE="/Users/roelfie/Dropbox/bin/work"
WORK_BIN_TARGET="/Users/roelfie/bin/work"

echo "\n<<< Configure ~/bin/work/ subdirectories >>>\n"

cd $WORK_BIN_SOURCE
for dir in *
do
    if [ -d "$dir" ]; then
        ln -svw "$WORK_BIN_SOURCE/$dir" "$WORK_BIN_TARGET/$dir"
    fi
done
