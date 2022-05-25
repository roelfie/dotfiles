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
PATH="$HOME/.n/bin:$PATH"
PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"



###############################################################################
###   Helper functions                                                      ###
###############################################################################

section() {
    echo "_______________________________________________________________________________"
    echo $1
    echo "\n"
}

display_notification() {
    # Use pync (python wrapper around terminal-notifier). Unlike the osascript variant it allows you to use icons, open files etc.
    # osascript -e 'display notification "'$1'" with title "Dotfiles"'
    $HOME/.pyenv/shims/python $HOME/.dotfiles/bookkeeper/notify.py \
        "Dotfiles" \
        "$1" \
        "file:///Users/roelfie/.dotfiles/bookkeeper/dotfiles_bookkeeper.log" \
        "file:///Users/roelfie/.dotfiles/bookkeeper/images/icons8-checked-checkbox-50.png"
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



###############################################################################
###   Upgrade homebrew packages                                             ###
###############################################################################

section "Upgrading Homebrew packages"

# Update Homebrew
brew update -q

# Upgrade outdated brew packages
OUTDATED_BREW_PKGS=($(brew outdated -q))
OUTDATED_BREW_PKGS_SIZE=${#OUTDATED_BREW_PKGS}
if [ $OUTDATED_BREW_PKGS_SIZE -gt 0 ]; then
    display_notification "Upgrading $OUTDATED_BREW_PKGS_SIZE outdated brew package(s)."
    echo "Found $OUTDATED_BREW_PKGS_SIZE outdated brew package(s):"
    echo $OUTDATED_BREW_PKGS
    brew upgrade
else
    echo "No outdated brew packages found."
fi



###############################################################################
###   Upgrade python packages                                               ###
###############################################################################

section "Upgrading Python packages"



###############################################################################
###   Upgrade node packages                                                 ###
###############################################################################

section "Upgrading Node packages"



###############################################################################
###   Backup installed homebrew, python & node packages                     ###
###############################################################################

# Generate Brewfile & vscode_extensions
section "Backup homebrew, python & node packages and vscode extensions"
cd $DOTFILES_HOME

echo "Backing up Homebrew packages to 'Brewfile'"
brew bundle dump --force

echo "Backing up Python packages to '???'"
# NB: 'pip list' also lists all dependencies. 
# Using the '--not-required' flag will only include everything that is not a dependency.
# But if you installed (and need) a pkg that happens to be a dependency of another installed pkg,
# 'pip list --not-required' will not include that package in the output anymore!
# Therefore we do not use the '--not-required' option (and end up with a list with a lot of crap).
#
# TODO find a way to export only those python packages that I've installed myself.
pip list --format freeze > $HOME/.dotfiles/backup/pip-requirements.txt

echo "Backing up global Node packages to 'npm.global.txt'"
backup-global backup --no-yarn --output $HOME/.dotfiles/backup/npm.global.txt

echo "Backing up vscode extensions to 'vscode_extensions'"
code --list-extensions > vscode_extensions



###############################################################################
###   Commit changes                                                        ###
###############################################################################

section "Commit changes"

# Check if there are changes in the .dotfiles project.
DIRTY_RAW=$(git status -s)
if [[ ${#DIRTY_RAW} = 0 ]]; then 
    echo "No changes found in .dotfiles project."; exit
else 
    echo "Changes found in .dotfiles project: \n$DIRTY_RAW"
fi

# If there are staged changes, always review manually
STAGED=($(git diff --name-only --cached))
if [[ ${#STAGED} > 0 ]]; then
    echo "Staged changes in .dotfiles project: \n$STAGED"
    review_dotfiles_project; exit
else
    echo "No staged changes found in .dotfiles project."
fi

# Some simple changes can be committed automatically
DIRTY=("${(f)DIRTY_RAW}") # one line per file
if [[ ${#DIRTY} = 1 ]]; then 
    # regex 'ends with'
    if [[ $DIRTY[1] =~ Brewfile$ ]]; then 
        git_commit_file $BREWFILE; exit
    fi
    if [[ $DIRTY[1] =~ vscode_extensions$ ]]; then 
        git_commit_file $VSCODE_EXTENSIONS; exit
    fi
fi

# All other changes must be reviewed manually
echo "Changes should be reviewed manually."
review_dotfiles_project; exit
