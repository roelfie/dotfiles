#!/usr/bin/env zsh

echo "\n<<< Manually register & configure apps >>>\n"

instruction() {
    print "\n\n$1"
    vared -p "Press [Enter] when finished. " -c REPLY
}

instruction "REGISTER the following applications. License keys can be found in 1Password:
    - betterzip
    - daisydisk
    - istatmenus
    - permute
    - textsniper"

instruction "beyond-compare:
    - Open Beyond Compare
    - It will ask to install Rosetta (bc4 was built for Intel)
    - Register (see 1Password)"

instruction "boxcryptor:
    - When first opening Boxcryptor, it will prompt you to install system extensions
      Boxcryptor will guide you through it
      (you will have to restart the system and hold the Touch ID or power button to launch Startup Security Utility)
    - Preferences / Locations: Dropbox

    NB: You may want to save this step (in particular the reboot) until the Dotbot installation process has completed"

instruction "forklift:
    - Register (see 1Password)
    - General: Compare Tool = beyond compare 
    - Editing: Visual studio Code (default)
    - Shortcuts: Key binding set = Commander
    - Shortcuts: Check 'Enable keyboard selection'
    - Shortcuts: 
        - Show hidden files = CMD .
        - Rename = CMD enter
        - Move to Trash = CMD backspace"

instruction "google-drive:
    - Sign in with the same account as you did with Google Chrome"

instruction "intellij-idea:
    - Get license from = 'JB Account'
       (we don't upload a license file; we just login)"

instruction "microsoft-office:
    - Open Excel
    - Sign in with my Microsoft Live Account   
    - This will register all Office apps"

instruction "oracle-jdk:
    - Check where the Oracle JDK was installed
      This is typically a folder in /Library/Java/JavaVirtualMachines/
    - Open setup_java.zsh and (if necessary) correct the entries in JAVA_HOME_LOCATIONS 
    - Save changes to setup_java.sh (this setup file will be run later on)"

instruction "oxygen-xml-editor:
    - Latest version (per april 2022) is v24; I only have a license for v22.
    - Rename '/application/Oxygen XML Editor' to somethings else (e.g. suffix '-v24')
    - Download & install v22
    - Open v22 and register (see 1Password)"

instruction "whatsapp:
    - Open WhatsApp Desktop
      it should display a QR code when opened for the first time
    - Open WhatsApp Android
      go to settings / linked devices, and scan the QR codde from the desktop"

echo "\n<<< Installing Visual Studio Code Extensions >>>\n"

cat vscode_extensions | xargs -L 1 code --install-extension