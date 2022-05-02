# Dotfiles from Start to Finish-ish

Notes taken from the Udemy course on Dotbot.

## Shells

Show a list of all available shells: `$ bat /etc/shells`

In macOS 12 (Monterey) `zsh` is the default interactive shell, but `zs` is the default non-interactive shell. `sh` however is just a symlink to bash. So the default non-interactive shell is still bash!

### What shell is running

Determine which shell is currently active:

```
echo $0 (current process)
echo $SHELL (default login shell of the system; can be changed in the system preferences) 
which zsh 
```

## pre-installed software vs. brew managed software

macOS comes shipped with a lot of tools that can typically be found in `/usr/bin`. These tools are not managed by brew so you can not easilly upgrade them. You can install the tool with brew. You will then end up with two versions, in two different locations, of the same tool:
 * the brew managed one in `/opt/homebrew/bin`
 * the pre-installed one in `/usr/bin`

The brew version normally takes precedence over the pre-installed version (appears first in the $PATH). And from now on you can easilly upgrade the tool to the newest version with brew.

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

A [here-string](https://tldp.org/LDP/abs/html/x17837.html) can be considered as a stripped-down form of a here document.
It consists of nothing more than 

```
COMMAND <<< $WORD
```

Example:

```
String="This is a string of words."
read -r -a Words <<< "$String"
```

## node

### n vs nvm

both are tools that manage multiple versions of node installed on the same machine.

```
brew install n
n help
n doctor
```

```
Checking n install destination priority in PATH...
There is a version of node installed which will be found in PATH before the n installed version.

Checking permissions for cache folder...
You do not have write permission to create: /usr/local/n
Suggestions:
- run n with sudo, or
- define N_PREFIX to a writeable location, or
- make a folder you own:
      sudo mkdir -p "/usr/local/n"
      sudo chown roelfie "/usr/local/n"
```

we've added N_PREFIX to our zshrc so n knows where to install node versions (without permission issues)

```
n lts
n latest
n -- this shows a list of all installed node versions
```

The "n <version>" command installs node version X in N_PREFIX/n/versions and also switches the current node version to that installed version.

However if you already had a node version installed before installing 'n' you will have seen "There is a version of node installed which will be found in PATH before the n installed version." in the output of 'n doctor' and the version changing won't work; will be FIXED later...

