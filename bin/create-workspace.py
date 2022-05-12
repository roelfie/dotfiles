# This script can be used to create a new workspace.
# 
# The result (with the help of 'setup_workspaces.zsh') is:
#  - a new entry in workspaces.conf.yaml
#  - a new directory under WORKSPACES_HOME with its own .gitconfig
#  - a reference to the new workspace in ~/.gitconfig

from os import path, environ
import subprocess

HOME = path.expanduser("~")
DOTFILES_HOME = environ.get('DOTFILES_HOME')
WORKSPACES_HOME = environ.get('WORKSPACES_HOME')
WORKSPACES_CONFIG = HOME + "/Dropbox/Apps/dotfiles/workspaces.conf.yaml"
WORKSPACES_INSTALL_SCRIPT = DOTFILES_HOME + "/scripts/setup_workspaces.zsh"

# Verify that workspaces config file exists.
if (not path.exists(f'{WORKSPACES_CONFIG}')):
    print(f'Abort. Configuration file not found: {WORKSPACES_CONFIG}')
    quit()

print("CREATE NEW WORKSPACE\n")

# Ask for new workspace details.
workspace_name = input("Workspace name: ")
git_user = input("      Git user: ")
git_email = input("     Git email: ")

# If workspace already defined in config file, abort!
config_file = open(WORKSPACES_CONFIG,  "r")
if workspace_name in config_file.read():
    print(f"Abort. Workspace already included in {WORKSPACES_CONFIG}\n")
    config_file.seek(0)
    print(config_file.read())    
    quit()

# If workspace directory already exists, abort!
if (path.exists(f'{WORKSPACES_HOME}/{workspace_name}')):
    print("Abort. Workspace already exists!")
    quit()

# Ask for confirmation.
answer = input(f'\nAre you sure you want to create workspace \'{workspace_name}\'? [y/n] ')
if (answer not in ['y', 'Y']):
    print("Abort. Workspace not created.")
    quit()

# Add new workspace details to config file.
print("\nAppending details to " + WORKSPACES_CONFIG)
config = """  - name: "{name}"
    git:
      username: "{user}"
      email: "{email}"
"""
config_file = open(WORKSPACES_CONFIG, 'a')
config_file.write(config.format(name = workspace_name, user = git_user, email = git_email))
config_file.close()

# Create actual workspace directory.
subprocess.run([WORKSPACES_INSTALL_SCRIPT, ""])

print("\nDONE")
