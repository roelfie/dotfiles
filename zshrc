echo "Hello from .zshrc"

# Set variables

# Change ZSH options

# Create aliases
alias l='ls -laFh'
alias ls='ls -laFh' # to issue the original ls command, run "command ls"
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


