#!/usr/bin/env zsh
#
# I have a macbook with M1 / ARM.
# Terraform provider support is limited for ARM.
# For example, the (deprecated) template_file is not supported on ARM:
# https://registry.terraform.io/providers/hashicorp/template/latest/docs
#
# But Homebrew on an M1 installs an ARM build of terraform.
#
# The 'tfenv' tool allows us to install an AMD terraform version. 
# https://github.com/tfutils/tfenv
#
# We have already installed tfenv with Homebrew.
# This script uses tfenv to install an AMD terraform version.
#

clear

echo "\n<<< Setup tfenv (terraform) >>>\n"

# install the latest version at the time of writing
TFENV_ARCH=amd64 tfenv install 1.3.5
tfenv use 1.3.5

echo ""
echo "Installed terraform versions: "
tfenv list

echo ""
vared -p "Press [Enter] to continue. " -c REPLY

echo ""
echo "Available terraform versions: "
tfenv list-remote | more

echo ""
echo "If you want to install a newer terraform version from the above list, do this:"
echo "TFENV_ARCH=amd64 tfenv install <version>"

echo ""
vared -p "Press [Enter] to continue. " -c REPLY
