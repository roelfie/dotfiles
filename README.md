# dotfiles

I use this project to bootstrap my MacBook.

It is based on [dotbot](https://github.com/anishathalye/dotbot) and does the following:

* install Homebrew
* install cli tools and applications
* install [dotfiles](https://dotfiles.github.io/) (i.e. config files for zsh, cli tools and applications)
* generate key pair and setup ssh connection with GitHub 
* and more ...


## Prerequisites

* password WiFi
* password Dropbox & 1Password
* fresh [macOS installation](https://www.macworld.com/article/668644/how-to-clean-install-macos-on-your-mac.html) (the script is somewhat idempotent, you should be able to re-run it at any time)
  * Apple ID (if you want to connect to iCloud during the macOS installation)

## Usage

1. Fresh macOS install on an M1 MacBook: 
   * Use the `Erase All Content and Settings` wizard under `System Preferences / System Preferences`.
2. Install xcode:
   ```
   xcode-select --install
   ```
3. Install the .dotfiles project:
   ```
   git clone https://github.com/roelfie/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   ./install
   ```
   This will trigger Dotbot to perform all the steps described in [install.conf.yaml](./install.conf.yaml).

NB: In [zshrc](./zshrc) we've configured the Homebrew `--no-quarantine` flag. So all appplications should be ready to use immediately after installation.


#### <a name="manual_steps"></a>Manual steps

* Configure the [bookkeeper](./bookkeeper/README.md) in LaunchControl
* System Preferences
  * BlueTooth: pair keyboard, phone & headphone
  * Security & Privacy (see screenshots Dropbox)
* Alfred key bindings

| app                | menu                             | hotkey                    | value     |
|--------------------|----------------------------------|---------------------------|-----------|
| System Preferences | Keyboard → Shortcuts → Spotlight | Show Spotlight search     | `^ Space` |
| System Preferences | Keyboard → Shortcuts → Spotlight | Show Finder search window | `⌥ Space` |
| Alfred             | General                          | Alfred Hotkey             | `⌘ Space` |
| Alfred             | Features                         | Clipboard History         | `⌥ ⌘ C`   |
| Alfred             | Features                         | Snippets                  | `⌥ ⌘ S`   |

## What does it do?

This dotfiles project does a couple of things.

#### Installing cli tools and applications

* installing cli tools (packages) with Homebrew
* installing applications (casks) with Homebrew
  * NB 1: some apps were purchased in the App Store; they are installed with [mas](https://github.com/mas-cli/mas) (listed as  'mas' instead of 'cask' in [Brewfile](./Brewfile))
  * NB 2: some apps were paid for, but not via the app store; they are installed as a 'cask'
  * NB 3: some apps are not available as cask nor in the App Store; they need to be installed manually

Only applications that have already been _purchased in the App Store_ can be automatically installed using `mas`. If you want to install a paid application for the first time, you have to manually pay for it in & install it from the App Store.

#### Backing up configurations

MacOS tools and applications typically store their configuration in [dotfiles](https://dotfiles.github.io/). For example `.zshrc` and `.gitconfig`. Or sometimes in directories, like `.config/bat`. We use two different ways of backing up these configuration files:

* this GitHub project (symlinks managed by [dotbot](https://github.com/anishathalye/dotbot))
  * use if you want to keep the config file under version control (like the `zsh` configuration files)
* Dropbox (symlinks managed by [mackup](https://github.com/lra/mackup/blob/master/README.md))
  * use if the config file contains confidential information (password, email, ..)

Beware that `dotfiles` and `mackup` can overlap. Always make sure that dot-files stored in this `dotfiles` project are excluded from mackup (`[applications_to_ignore]` section in [mackup.cfg](./mackup.cfg)).

The default backup mechanism we use is mackup (backup to Dropbox unless ignored in mackup.cfg).

## HOW TO keep dotfiles up-to-date

Anything you consider part of your standard toolset / configuration should be added to this dotfiles project. If this is not possible (or too hard) consider adding it to the [Manual Steps](#manual_steps) section.

Disclaimer: In the following HOW TOs I describe _my_ way of working with this dotfiles project. This is not necessarilly _the (best)_ way to work with dotfiles.

For all the following tasks: When you're finished, check if you need to commit any changes to the `dotfiles` project!

### HOW TO - update Brewfile

Whenever you install or uninstall a package or application, you want this reflected in [Brewfile](./Brewfile). Instead of editing Brewfile manually, my preferred way of working is to install or uninstall with brew, and afterwards update the Brewfile with the following command:

```
brew bundle dump --force
brewdump # alias for the same thing
```


### HOW TO - install a new brew

Command line tools are installed with brew. Homebrew's default install directory on Apple Silicon is `/opt/homebrew/bin` (see `$HOMEBREW_PREFIX`).

Check whether a package is already installed (either with homebrew or otherwise):

```
brew search <pkg>
brew info <pkg>
brew bundle list --brews
which -a <pkg>
```

Install a package:
```
brew install <pkg>
```

Carefully read the caveats section in the output of `brew install`. You may have to perform some manual tasks to complete the installation (like adding stuff the PATH in `.zshrc`).

* update Brewfile: `brewdump`
* commit your changes to `~/.dotfiles`


### HOW TO - install a new PAID application

Check whether an application is already installed (either as cask or with mas):

```
brew search <app>
brew info <app>
brew bundle list --casks
brew bundle list --mas

mas list
mas search <app>
```

You have two options: 
1. buy & install in the App Store
2. install as a brew cask

The preferred way is to _not_ install with the App Store, because that will tie your purchase to the Apple account at the time of purchase, and it's not possible to transfer an app to another account. 

Whenever possible, install as cask or download the application manually, and buy the license on the vendor's website (this worked for instance for 1Password, oXygen XML):

* Installation:
  * ```
    brew install <app>
    brewdump
    ```
  * buy license on vendor's website
  * commit your changes to `~/.dotfiles`
* Installation (App Store):
  * if app can _only_ be purchased from the App Store, use the App Store.


### HOW TO - install a new FREE application

Check whether an application is already installed (either as cask or with mas):

```
brew search <app>
brew info <app>
brew bundle list --casks
brew bundle list --mas

mas list
mas search <app>
```

* Installation (brew):
  * ```
    brew install <app>
    brewdump
    ```
  * commit your changes to `~/.dotfiles`
* Installation (App Store):
  * if you can't find a brew cask for the application, use the App Store.


#### Mismatch brew cask and mas

Before installing an application (either `cask` or `mas`) always double check its version.

In the case of Forklift, the version managed by `mas` is very old:

```
$ brew info forklift
forklift: 3.5.6

$ mas search forklift
412448059  ForkLift - File Manager (2.6.6)
$ mas info 412448059
ForkLift - File Manager 2.6.6
```

In this example, it is better to ignore it and install the brew `cask`.


### HOW TO - remove an application

If you want to remove an application (either a standard one from Apple shipped with your mac, or a 3rd party),

```
mas list
mas info <app-id>

brew bundle list --casks
brew bundle list --mas

mas uninstall <app-id>

brewdump

# commmit changes to ~/.dotfiles
```

If the application is not found with `mas list` or `brew bundle list` it was installed manually and you can probably uninstall it simply by dragging it onto the bin.

### HOW TO - (un)install an Oracle JDK

There are detailed [instructions](https://docs.oracle.com/en/java/javase/18/install/installation-jdk-macos.html) on the Oracle website explaining how to install or remove a JDK on macOS.

Installation: 

* `brew install --cask oracle-jdk`
* check that the JDK ends up in `/Library/Java/JavaVirtualMachines`
* add JDK Home directory to [JAVA_HOME_LOCATIONS](./setup_java.zsh) in `setup_java.sh`
  * Example: `/Library/Java/JavaVirtualMachines/jdk-18.jdk/Contents/Home`
* re-run `~/.dotfiles/setup_java.sh` to have the new JDK version added to jenv

Removal:

* `brew uninstall --cask oracle-jdk`
* remove JDK Home directory from [JAVA_HOME_LOCATIONS](./setup_java.zsh) in `setup_java.sh`
* remove symlink manually from `~/.jenv/versions`

TODO: the `oracle-jdk` cask has no version name. Is it possible to install multiple Oracle JDK versions alongside each other?


## HOW TO upgrade brews and apps

Running the dotbot install script should upgrade all installed brews to the newest version, but may be overkill.

* Upgrade brews:
  * ```
    brew update
    brew outdated
    brew upgrade
    ```
  * you can also upgrade one package with `brew upgrade <pkg>`
* Upgrade apps (casks):
  * use the application GUI
  * many apps can be configured to auto-update


### HOW TO - upgrade a pre-installed package

MacOS comes with a list of pre-installed tools in `/usr/bin`.
For example `less`, `keytool`, `more`, `ssh`, `zip`, etc ...

You don't want to mess around with the tools in `/usr/bin`. 
If you want to be able to manage one of these tools with Homebrew (and always use the latest version) you can install the tool alongside the pre-installed one:

```
which -a <pkg>
<pkg> --version

brew search <pkg>
brew install <pkg>
brew info <pkg>

# open a new shell
zsh
which -a <pkg>
<pkg> --version
```

As long as `/opt/homebrew/bin` appears before `/usr/bin` on the `$PATH` the brew version will take precedence. On the last line you should see the newest version (installed with brew) instead of the pre-installed version.

See [README-UDEMY](./README-UDEMY.md) for an example (nano).


## HOW TO install a Visual Studio Code extension

1. Install the extension in vscode
2. Export the complete list of installed extensions: `vscodedump` (see `.aliases`)
3. commit the change to the `.dotfiles` project

## macOS 'defaults' command

The 'defaults' command allows users to read and write macOS user defaults from the command line.

* [macos-defaults.com](https://macos-defaults.com/)
* Blog post on [cfprefsd](https://eclecticlight.co/2019/08/22/working-safely-and-effectively-with-preferences-in-mojave/)
* [macOS Prefs Editor](http://apps.tempel.org/PrefsEditor/index.php)
* Example of a [script with lots of defaults](https://github.com/mathiasbynens/dotfiles/blob/main/.macos)
* and `defaults` has its own man page: `man defaults` or `defaults help`


## ToDo

Things I'd still like to automate with my dotfiles project:

* Uninstall pre-installed applications from Apple (like Numbers, Notes, Pages, Music, Messages, Maps, Mail, Stocks, Siri, Contacts, Dictionary, Keynote, GarageBand iMovie, ..)


## References

 * [Dotfiles from Start to Finish-ish](https://www.udemy.com/course/dotfiles-from-start-to-finish-ish/) - course (Udemy)
 * [Patrick McDonalds dotfiles repo](https://github.com/eieioxyz/dotfiles_macos) - github
 * [Youtube](https://www.youtube.com/watch?v=kIdiWut8eD8)

