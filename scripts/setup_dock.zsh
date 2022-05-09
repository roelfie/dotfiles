#!/usr/bin/env zsh
# 
# https://stackoverflow.com/questions/67026378/customize-macoss-dock-with-a-bash-script
# https://www.tech-otaku.com/mac/add-recent-or-favorites-folder-to-your-dock-using-macos-terminal/
# https://www.intego.com/mac-security-blog/unlock-the-macos-docks-hidden-secrets-in-terminal/

echo "\n<<< Setup the Dock >>>\n"

HOME=~
ICONS_FOLDER=$HOME/.dotfiles/resources/dock/icons
STACKS_FOLDER=$HOME/.config/dock/stacks
# each stack has its own icon, and the icon name will be used as the stack (folder) name
STACKS=($(cd $ICONS_FOLDER; ls -1 *.icns | sed -e 's/\.icns//g'))

APPS=(
    '//Applications//Google Chrome.app'
    '//System/Applications//Utilities//Terminal.app'
    '//Applications//ForkLift.app'
)


# 0: Start with clean slate
if [ -d "$STACKS_FOLDER" ]; then
    echo "Remove existing stacks"
    rm -rf "$STACKS_FOLDER"
fi

defaults delete com.apple.dock persistent-apps
defaults delete com.apple.dock persistent-others

# 1: Prepare 'stacks' folders
echo "Create new (empty) stacks"
mkdir "$STACKS_FOLDER"
for stack in ${STACKS[@]}; do
    mkdir "$STACKS_FOLDER/$stack"
    fileicon set "$STACKS_FOLDER/$stack" "$ICONS_FOLDER/$stack.icns"
done


# 2: Add apps to Dock
echo "Add apps to Dock"
for app in ${APPS[@]}; do
    defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
done

# 3: Add folders to Dock
#
# Sort by:         Name   (1)
# Display as:      Folder (1)
# View content as: List   (3)
#
# Below config is added to ~/Library/Preferences/com.apple.dock.plist.
#
COM_APPLE_DOCK_PLIST_TEMPLATE=$(cat <<"EOF"
<dict>
    <key>tile-data</key>
    <dict>
        <key>arrangement</key>
        <integer>1</integer>
        <key>displayas</key>
        <integer>1</integer>
        <key>file-data</key>
        <dict>
            <key>_CFURLString</key>
            <string>file://_FOLDER_</string>
            <key>_CFURLStringType</key>
            <integer>15</integer>
        </dict>
        <key>file-label</key>
        <string>_LABEL_</string>
        <key>file-type</key>
        <integer>2</integer>
        <key>preferreditemsize</key>
        <integer>-1</integer>
        <key>showas</key>
        <integer>3</integer>
    </dict>
    <key>tile-type</key>
    <string>directory-tile</string>
</dict>
EOF
)

add_folder_to_dock() {
    expanded=${COM_APPLE_DOCK_PLIST_TEMPLATE//_FOLDER_/$1}
    expanded=${expanded//_LABEL_/$2}
    printf $expanded
}

echo "Add stacks to Dock"
for stack in ${STACKS[@]}; do
    defaults write com.apple.dock persistent-others -array-add "$(add_folder_to_dock $STACKS_FOLDER/$stack $stack)"
done

killall Dock


# 4: Populate folders
echo "Populate stacks"

cd $STACKS_FOLDER/apps
    ln -s /Applications/BetterZip.app "BetterZip"
    ln -s /Applications/iDMSS\ Plus.app "iDMSS Plus (Dahua NVR)"
    ln -s /Applications/Alfred\ 4.app "Alfred"
    ln -s /Applications/LaunchControl.app "LaunchControl"

cd $STACKS_FOLDER/dev
    ln -s /Applications/Oxygen\ XML\ Editor/Oxygen\ XML\ Editor.app "Oxygen XML Editor"
    ln -s /Applications/Beyond\ Compare.app "Beyond Compare"
    ln -s /Applications/IntelliJ\ IDEA.app "IntelliJ IDEA"
    ln -s /Applications/PyCharm\ CE.app "PyCharm"
    ln -s /Applications/Peek.app "Peek (QuickLook plugin)"

cd $STACKS_FOLDER/docs
    ln -s /Applications/Skim.app "Skim"
    ln -s /Applications/Visual\ Studio\ Code.app "vscode"
    ln -s /Applications/Microsoft\ Word.app "MS Word"
    ln -s /Applications/Microsoft\ Excel.app "MS Excel"
    ln -s /Applications/Microsoft\ PowerPoint.app "MS PowerPoint"

cd $STACKS_FOLDER/graphics
    ln -s /Applications/Xee³.app "Xee"
    ln -s /Applications/Pixelmator\ Pro.app "Pixelmator"
    ln -s /System/Applications/Utilities/Digital\ Color\ Meter.app "Digital Color Meter"
    ln -s /Applications/Permute\ 3.app "Permute"
    ln -s /Applications/Squash.app "Squash"

cd $STACKS_FOLDER/sys
    ln -s /System/Applications/System\ Preferences.app "System Preferences"
    ln -s /System/Applications/Utilities/Activity\ Monitor.app "Activity Monitor"
    ln -s /System/Applications/Utilities/System\ Information.app "System Information"
    ln -s /Applications/DaisyDisk.app "DaisyDisk"
    ln -s /Applications/Prefs\ Editor.app "Prefs Editor"
