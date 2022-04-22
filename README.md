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

#### removing applications

If you want to remove an application (either a standard one from Apple shipped with your mac, or a 3rd party),

```
mas uninstall <app-id>
brew bundle dump --force
```

The last step is required so that on a new dotbot install the application will not be reinstalled.

the app-id can be found using `mas list`.

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

Remove standard apps: 

 * Numbers, Notes, Pages, Music, Messages, Maps, Mail, Stocks, Siri, Contacts, Dictionary, Keynote, GarageBand and iMovie

## Shells

Show a list of all available shells: `$ bat /etc/shells`

In macOS 12 (Monterey) `zsh` is the default interactive shell, but `zs` is the default non-interactive shell. `sh` however is just a symlink to bash. So the default non-interactive shell is still bash!


## pre-installed software vs. brew managed software

macOS comes shipped with a lot of tools that can typically be found in `/usr/bin`.
These tools are not managed by brew.
If you want to upgrade one of these tools to its newest version with brew, you will have to do a full install with brew and you will end up with two versions in two different locations:
 * the pre-installed one in `/usr/bin`
 * the brew managed one in `/opt/homebrew/bin`

Example `nano`:

```
$ nano --version 
  GNU nano version 2.0.6 (compiled 18:33:35, Oct  1 2021)

$ brew info 
  nano: stable 6.2 (bottled)
  Not installed

$ which -a nano
  /usr/bin/nano

$ brew install nano
$ brew info nano
  nano: stable 6.2 (bottled)
  /opt/homebrew/Cellar/nano/6.2 (102 files, 3MB) *  

$ zsh

$ nano --version
  GNU nano, version 6.2

$ which -a nano
  /opt/homebrew/bin/nano
  /usr/bin/nano

$ exa $(which -a nano)
Permissions Size User    Date Modified Git Name
lrwxr-xr-x    27 roelfie 22 Apr 10:16   -I /opt/homebrew/bin/nano -> ../Cellar/nano/6.2/bin/nano*
.rwxr-xr-x  375k root    18 Oct  2021   -- /usr/bin/nano*
```

Result: We have two versions of `nano` on our system. Since the homebrew version apperars at the top, that's the one that will be used when we open `nano`.

Brew managed stuff is here
```
exa /opt/homebrew/bin
```

## PATH

The default PATH before we start hacking additional entries into it, is `/etc/paths`.

We have defined a `trail` alias in .zshrc to better view the path (each entry on a separate line):

```
alias trail='<<<${(F)path}'
```

`$path` is an environment variable similar to `$PATH` but it is an array instead of a colon separated string.

Let's disect the above expression.
From the zsh docs on [parameter expansion](https://zsh.sourceforge.io/Doc/Release/Expansion.html#Parameter-Expansion):


> The character ‘\$’ is used to introduce parameter expansions. 

> ${name} : more complicated forms of substitution usually require the braces to be present

> ${#spec} : If spec is an array expression, substitute the number of elements of the result.

So `${#path} will print the number of elements in the $PATH.

> If the opening brace is directly followed by an opening parenthesis, the string up to the matching closing parenthesis will be taken as a list of flags.

> F : Join the words of arrays together using newline as a separator.

So `${(F)path}` will print each element in the `path` array on a separate line.

This all does the same thing:

```
echo ${(F)path}
cat <<<${(F)path}
<<<${(F)path}
```

`cat` is the default for a [here-string](https://tldp.org/LDP/abs/html/x17837.html) so can be omitted. 

### here-documents

A [here-document](https://tldp.org/LDP/abs/html/here-docs.html) is a special-purpose code block to feed a command list to an interactive program or a command (like ftp, cat or a text editor).

```
COMMAND <<InputComesFromHERE
...
...
...
InputComesFromHERE
```

### here-strings

A [here-string]() can be considered as a stripped-down form of a here document.
It consists of nothing more than 

```
COMMAND <<< $WORD
```

Example:

```
String="This is a string of words."
read -r -a Words <<< "$String"
```


