#!/usr/bin/env zsh

echo "\n<<< Setup oh-my-zsh >>>\n"


open https://github.com/ohmyzsh/ohmyzsh#basic-installation

echo "Before we continue with the 'oh-my-zsh' installation"
echo "please check in the ohmyzsh README (see browser)"
echo "that the commands in 'setup_ohmyzsh.zsh' are still up-to-date."
echo ""
vared -p "Do you want to Continue [Enter] or Quit [q] ? " -c ANSWER

if [[ $ANSWER && $ANSWER = "q" ]]
then
    echo "Quiting oh-my-zsh installation."
    echo "Please fix 'setup_ohmyzsh.zsh' to reflect the newest installation instructions."
    exit 0
fi


open https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k

echo ""
echo "The 'powerlevel10k' theme was installed earlier with Homebrew."
echo "This theme requires the 'Meslo Nerd Font'."
echo "This font should be installed manually."
echo "Please install the font using the online instructions (see browser)."
echo "Then change your Terminal Profile to 'Pro' (black background)."
echo "Next, select the installed font in macOS Terminal: Preferences → Profiles → Text → Font"
echo ""
echo ""
vared -p "Press [Enter] when done." -c IGNOREME


# Pass flags as described in the header of install.sh:
#   --skip-chsh:  the installer will not change the default shell
#   --keep-zshrc: the installer will not replace an existing .zshrc
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --skip-chsh --keep-zshrc


echo "oh-my-zsh and powerlevel10k installation finished."
echo "The first time you open a new zsh shell, the p10k configuration wizard should start."
echo "But you can always run 'p10k configure' at a later moment."
echo ""

vared -p "Press [Enter] to continue." -c IGNORE