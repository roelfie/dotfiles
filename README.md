# dotfiles

Dotbot project containing my macOS dotfiles.

Background reading:

 * [dotbot](https://github.com/anishathalye/dotbot) - tool
 * [dotfiles](https://dotfiles.github.io/) - guide
 * [Dotfiles from Start to Finish-ish](https://www.udemy.com/course/dotfiles-from-start-to-finish-ish/) - course (Udemy)

## Workflow

Some rules to keep your machine and the dotbot config in sync:

 * Never edit Brewfile manually. 
 * Instead just `brew install package` and occasionally generate a new Brewfile with `brew bundle dump --force`.


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
