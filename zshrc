echo "Loading .zshrc"

# .zshrc is loaded by interactive shells

# Set variables
export HOMEBREW_CASK_OPTS="--no-quarantine"
export N_PREFIX=$HOME/.n
export JENV_PREFIX=$HOME/.jenv

# Path
typeset -U path
# The order of the entries in path below is important!
# By putting 'n' and 'jenv' at the top, the node & Java versions installed with 
# n & brew take precedence over the pre-installed versions that come with macOS.
path=(
    "$N_PREFIX/bin"
    "$JENV_PREFIX/bin"
    $path
    "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
    "/Applications/Beyond Compare.app/Contents/MacOS"
)

# Aliases
alias cls='clear'
alias cat='bat'
alias man='batman'
alias rm='trash'
alias brewdump='cd ~/.dotfiles; brew bundle dump --force; cd -'
alias trail='<<<${(F)path}' # each entry in $PATH on a new line
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
alias l2='exa --tree --level=2'
alias l3='exa --tree --level=3'
alias l4='exa --tree --level=4'
alias l5='exa --tree --level=5'
lsdr() {exa -aDT --level="$1"}

# Customize prompt
PROMPT='%1~ %L %# ' # current folder _ shell level
RPROMPT='%*'        # time (24h)

# Initialize jEnv
eval "$(jenv init -)"
