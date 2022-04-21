echo "Hello from .zshrc"

# Add Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Set variables
# syntax highlighting for man pages using bat
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export HOMEBREW_CASK_OPTS="--no-quarantine"

# Change ZSH options

# Create aliases
# alias ls='ls -laFh' # to issue the original ls command, run "command ls"
alias exa='exa -laFh --git'
alias ls='exa -laFh --git'
alias l2='exa --tree --level=2'
alias l3='exa --tree --level=3'
alias l4='exa --tree --level=4'
alias l5='exa --tree --level=5'
alias l='ls'
alias cls='clear'

# Customize prompt
PROMPT='%1~ %L %# ' # current folder _ shell level
RPROMPT='%*'        # time (24h)

# Add locations to $PATH

# Handy functions
mkcd () {
    mkdir -p "$@" && cd "$_"
}

# ZSH plugins

# Miscellaneous


