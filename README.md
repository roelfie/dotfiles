# dotfiles

Dotbot project containing my macOS dotfiles.

Background reading:

 * [dotbot](https://github.com/anishathalye/dotbot) - tool
 * [dotfiles](https://dotfiles.github.io/) - guide
 * [Dotfiles from Start to Finish-ish](https://www.udemy.com/course/dotfiles-from-start-to-finish-ish/) - course (Udemy)

## Workflow

Some rules to keep your machine and the dotbot config in sync:

### Brew bundle dump

 * Never edit Brewfile manually. 
 * Instead just `brew install package` and occasionally generate a new Brewfile with `brew bundle dump --force`.

### mas 

Mac AppStore

 * Apps that can not be installed with brew will be installed with `mas-cli` (mas = Mac AppStore)
   * installation can be done automatically if it has been purchased / installed from the appstore before
   * if it is the first time you install it, you will still have to do it manually in the appstore

```
mas list
mas search <app>
mas install <app>
```

### dotbot

Running the dotbot install script will update our packages (brews) when new versions are available. 

Manual would be:

```
brew update
brew outdated -- checks if there are outdated packages
brew upgrade <package>
brew upgrade -- upgrades all outdated packages and apps
```

Upgrading of apps (casks) is managed by the application itself (GUI). Many applications can be configured (in the preferences) to auto-updated themself.

## TODO

Add the following casks:

```
cask "1password"
cask "betterzip"
cask "beyond-compare"
cask "boxcryptor"
cask "daisydisk"
cask "dropbox"
cask "forklift"
cask "google-chrome"
cask "google-drive"
cask "gitkraken"
cask "intellij-idea"
cask "istat-menus"
cask "kindle"
cask "microsoft-office"
cask "nordvpn"
cask "open-office"
cask "oxygen-xml-editor"
cask "pycharm-ce"
cask "skim"
cask "textsniper"
cask "visual-studio-code"
cask "whatsapp"
cask "xee"
```

Casks not found (install manually from appstore): 

 * peek (quicklook plugins)
 * pixelmator pro
 * squash (applaudables)
 * aeon timeline
