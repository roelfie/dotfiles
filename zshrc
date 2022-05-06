echo "Loading .zshrc"

# .zshrc is loaded by interactive shells

# Set variables
export HOMEBREW_CASK_OPTS="--no-quarantine"
export N_PREFIX=$HOME/.n

# Give the 'n' managed version of node precedence over the homebrew managed version by *pre*pending it to $path.
# Always use 'n' to (un)install node or switch the current node version.
typeset -U path
path=(
    "$N_PREFIX/bin"
    $path
    "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
    "/Applications/Beyond Compare.app/Contents/MacOS"
)

# Change ZSH options

# Create aliases

# exa
#  -a  Show hidden en dot files
#  -h  Add a header row to each column
#  -l  Display extended file metadata as a table
#  -D  List only directories
#  -F  Display file kind indicators
#  -T  Recurse into directories as a tree
alias exa='exa -hlF --git --group-directories-first'
alias ls='exa'
alias l='exa'
alias la='exa -a'
alias lsa='exa -a'
alias lsd='exa -aD'
lsdr() {exa -aDT --level="$1"}
alias l2='exa --tree --level=2'
alias l3='exa --tree --level=3'
alias l4='exa --tree --level=4'
alias l5='exa --tree --level=5'

alias cls='clear'
alias man='batman'
alias brewdump='cd ~/.dotfiles; brew bundle dump --force; cd -'
alias cat='bat'
# show each entry in the $PATH variable on a new line
alias trail='<<<${(F)path}'
alias rm=trash

# Customize prompt
PROMPT='%1~ %L %# ' # current folder _ shell level
RPROMPT='%*'        # time (24h)

# ZSH plugins
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
