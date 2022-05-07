#!/usr/bin/env zsh
#
# This script attempts to reflect changes to the system in the .dotfiles 
# project, and (if possible automatically) commit & push them to GitHub:
# 
#  - upgrade all outdated brew packages
#  - generate Brewfile
#  - generate vscode_extensions
#  - commit changes to Brewfile or vscode_extensions automatically
#  - all other changes: open .dotfiles project in Visual Studio Code for review
#
DOTFILES_HOME="/Users/roelfie/.dotfiles"
BREWFILE="Brewfile"
VSCODE_EXTENSIONS="vscode_extensions"


review_dotfiles_project() {
    MESSAGE=".dotfiles contains uncommitted work\r\rPLEASE REVIEW" 
    osascript -e "display alert \"Dotfiles\" message \"$MESSAGE\""
    # Open .dotfiles in Visual Studio Code
    /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code --new-window ~/.dotfiles
}

git_commit_file() {
    echo "Commit & push $1."
    git add $1
    git commit -m "Updated $1 (auto-commit)."
    git push
}


# Upgrade outdated brew packages
OUTDATED_BREW_PKGS=($(brew outdated -q))
OUTDATED_BREW_PKGS_SIZE=${#OUTDATED_BREW_PKGS}
if [ $OUTDATED_BREW_PKGS_SIZE -gt 0 ]; then
    echo "Found $OUTDATED_BREW_PKGS_SIZE outdated brew packages."
    MESSAGE="Upgrading $OUTDATED_BREW_PKGS_SIZE outdated brew packages."
    osascript -e 'display notification "'$MESSAGE'" with title "Dotfiles"'
    echo "brew upgrade"
fi


# Generate Brewfile & vscode_extensions
cd $DOTFILES_HOME
brew bundle dump --force
code --list-extensions > vscode_extensions


# If there are staged changes, review manually
STAGED=($(git diff --name-only --cached))
if [[ ${#STAGED} > 0 ]]; then
    echo "Found staged changes in the .dotfiles project. Review manually."
    review_dotfiles_project; exit
fi


# Some simple changes can be committed automatically
DIRTY=("${(f)$(git status -s)}") # one line per file
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
