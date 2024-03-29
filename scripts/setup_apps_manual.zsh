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
    - launchcontrol
    - permute
    - textsniper"

instruction "beyond-compare:
    - Open Beyond Compare
    - It will ask to install Rosetta (bc4 was built for Intel)
    - Register (see 1Password)"

instruction "Docker Desktop:
    - Click on the Docker icon in the menu bar, and open the Preferences
    - Open tab 'Kubernetes'
    - Check 'Enable Kubernetes'
      This will install Kubernetes & kubectl
    - Eventually you should see 'Kubernetes is running' under the Docker Desktop menu"

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
    - Open the Jetbrains Toolbox. We install all of our Jetbrains products from with the Toolbox.
    - Get license from = 'JB Account'
       (we don't upload a license file; we just login)
    - In the JetBrains Toolbox App, go to IntelliJ > Settings > Configuration > Configure Shell Scripts Generation...
        and choose the default settings. This will install the 'idea' command line launcher.
        Do the same for DataGrip, PyCharm, etc."

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

instruction "pluralsight:
    - Open the Pluralsight app and log in (see 1Password)"

instruction "whatsapp:
    - Open WhatsApp Desktop
      it should display a QR code when opened for the first time
    - Open WhatsApp Android
      go to settings / linked devices, and scan the QR codde from the desktop"

echo "\n<<< Installing Visual Studio Code Extensions >>>\n"

cat $HOME/.dotfiles/backup/vscode_extensions | xargs -L 1 code --install-extension
