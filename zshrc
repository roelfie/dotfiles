echo "Hello from .zshrc"

# .zshrc is only loaded by interactive zshrc shells

# Add Visual Studio Code & Beyond Compare binaries to PATH
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH="$PATH:/Applications/Beyond Compare.app/Contents/MacOS"

# Set variables
# syntax highlighting for man pages using bat
# export MANPAGER="sh -c 'col -bx | bat -l man -p'"
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
alias man='batman'
alias brewdump='brew bundle dump --force --describe'
alias cat='bat'

# Customize prompt
PROMPT='%1~ %L %# ' # current folder _ shell level
RPROMPT='%*'        # time (24h)

# Add locations to $PATH

# ZSH plugins

# Miscellaneous


