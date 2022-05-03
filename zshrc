echo "Hello from .zshrc"

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
alias exa='exa -laFh --git'
alias ls='exa -laFh --git'
alias l2='exa --tree --level=2'
alias l3='exa --tree --level=3'
alias l4='exa --tree --level=4'
alias l5='exa --tree --level=5'
alias l='ls'
alias cls='clear'
alias man='batman'
alias brewdump='brew bundle dump --force'
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
