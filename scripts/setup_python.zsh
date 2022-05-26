#!/usr/bin/env zsh

echo "\n<<< Setup Python >>>\n"

# Python versions are managed with 'pyenv' which is in the Brewfile.
# See zshrc for PYENV_PREFIX and addition to the PATH.

open https://github.com/pyenv/pyenv/wiki#suggested-build-environment

echo "pyenv should already have been installed with Homebrew:"
echo `pyenv --version`
echo "Before we continue, it is recommended that you now (manually) install the python build dependencies for macOS."
echo "Please follow the instructions on the pyenv web page that we have opened in your browser."
echo "(typically something like 'brew install openssl readline sqlite3 xz zlib tcl-tk')"
vared -p "Press [Enter] to continue. " -c REPLY

echo "Installing the latest python version into $PYENV_ROOT/versions."
pyenv install --skip-existing 3:latest

echo "Latest python 3 version installed. Available versions: "
pyenv versions

echo "Open a new terminal and do 'pyenv global <version>' to select the latest python version (if necessary)."
echo "When you have selected the desired version, we will install global python packages."
vared -p "Press [Enter] when done. " -c REPLY

echo "Installing global python packages."
pip install -r $HOME/.dotfiles/backup/pip.requirements.txt
