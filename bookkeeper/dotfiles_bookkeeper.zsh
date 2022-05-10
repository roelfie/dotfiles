#!/usr/bin/env zsh
#
# This script attempts to reflect changes to the system in the .dotfiles 
# project, and (if possible automatically) commit & push them to GitHub:
# 
#  - upgrade all outdated brew packages
#  - generate Brewfile
#  - export Visual Studio Code extensions to 'vscode_extensions'
#  - commit changes to Brewfile or vscode_extensions automatically
#  - all other changes: open .dotfiles project in Visual Studio Code for review
#

echo " "
echo "<*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*>"
echo "┌┐ ┌─┐┌─┐┬┌─┬┌─┌─┐┌─┐┌─┐┌─┐┬─┐"
echo "├┴┐│ ││ │├┴┐├┴┐├┤ ├┤ ├─┘├┤ ├┬┘"
echo "└─┘└─┘└─┘┴ ┴┴ ┴└─┘└─┘┴  └─┘┴└─"
echo "$(date "+%Y-%m-%d %H:%M:%S")"
echo " "


DOTFILES_HOME="/Users/roelfie/.dotfiles"
BREWFILE="Brewfile"
VSCODE_EXTENSIONS="vscode_extensions"

PATH="/opt/homebrew/bin:$PATH"
PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"


display_notification() {
    osascript -e 'display notification "'$1'" with title "Dotfiles"'
}

display_alert() {
    osascript -e "display alert \"Dotfiles\" message \"$1\""
}

review_dotfiles_project() {
    display_alert ".dotfiles contains uncommitted work\r\rPLEASE REVIEW"
    # Open .dotfiles in Visual Studio Code
    /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code --new-window ~/.dotfiles
}

git_commit_file() {
    echo "Commit & push $1."
    git add $1
    git commit --author="bookkeeper <>" -m "Updated $1 (auto-commit)."
    git push
    display_notification "Committed change in $1."
}


# Update Homebrew
echo "Updating Homebrew"
brew update


# Upgrade outdated brew packages
OUTDATED_BREW_PKGS=($(brew outdated -q))
OUTDATED_BREW_PKGS_SIZE=${#OUTDATED_BREW_PKGS}
if [ $OUTDATED_BREW_PKGS_SIZE -gt 0 ]; then
    display_notification "Upgrading $OUTDATED_BREW_PKGS_SIZE outdated brew package(s)."

    echo "Found $OUTDATED_BREW_PKGS_SIZE outdated brew package(s):"
    echo $OUTDATED_BREW_PKGS
    echo "\n_______________________________________________________________________________"
    brew upgrade
    echo "_______________________________________________________________________________\n"
else
    echo "No outdated brew packages found."
fi


# Generate Brewfile & vscode_extensions
cd $DOTFILES_HOME
echo "Generating Brewfile and vscode_extensions."
brew bundle dump --force
code --list-extensions > vscode_extensions


# If there are staged changes, review manually
STAGED=($(git diff --name-only --cached))
if [[ ${#STAGED} > 0 ]]; then
    echo "Staged changes in .dotfiles project: \n$STAGED"
    review_dotfiles_project; exit
else
    echo "No staged changes found in .dotfiles project."
fi


# Some simple changes can be committed automatically
DIRTY_RAW=$(git status -s)
DIRTY=("${(f)DIRTY_RAW}") # one line per file
echo "Unstaged changes found in .dotfiles project: \n$DIRTY_RAW"
if [[ ${#DIRTY} = 1 ]]; then 
    if [[ $DIRTY[1] =~ Brewfile$ ]]; then 
        git_commit_file $BREWFILE; exit
    fi
    if [[ $DIRTY[1] =~ vscode_extensions$ ]]; then 
        git_commit_file $VSCODE_EXTENSIONS; exit
    fi
fi


# All other changes must be reviewed manually
if [[ ${#DIRTY} > 0 ]]; then
    echo "Found changes in the .dotfiles project. Review manually."
    review_dotfiles_project; exit
fi
