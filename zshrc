# .zshrc is loaded by interactive shells

# VARIABLES
export HOMEBREW_CASK_OPTS="--no-quarantine"
export N_PREFIX="$HOME/.n"
export JENV_PREFIX="$HOME/.jenv"
export PYENV_ROOT="$HOME/.pyenv"
export DOTFILES_HOME="$HOME/.dotfiles"
export WORKSPACES_HOME="$HOME/workspaces"

# PATH
# The order of entries in the path is important! By putting pyenv, jenv & n at the top, the Python/Java/Node
# versions installed with those tools take precedence over pre-installed versions that come with macOS.
# NB: cli tools for vscode & bc4 are installed with homebrew and are already on the PATH (/opt/homebrew/bin).
typeset -U path
path=(
    "$N_PREFIX/bin"
    "$JENV_PREFIX/bin"
    "$PYENV_ROOT/bin"
    $path
    "$HOME/bin"
)
# Add all client scripts to PATH
for dir in $HOME/work/*
do
    if [ -d "$dir" ]; then
        path=(
            $path
            "$dir/bin"
            "$dir/bin/git"
        )
    fi
done


# jEnv
eval "$(jenv init -)"

# pyenv
eval "$(pyenv init -)"

# oh-my-zsh 
export ZSH="$HOME/.oh-my-zsh"
HIST_STAMPS="yyyy-mm-dd"
plugins=(git
    aws
    docker
    httpie
    jenv
    mvn
    node
    python
    vscode
)
source $ZSH/oh-my-zsh.sh

# powerlevel10k
# https://github.com/romkatv/powerlevel10k#homebrew
source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ALIASES
# Source after oh-my-zsh otherwise some of our aliases may be overwritten by omz
source ~/.aliases


# AWS-CLI Auto Complete   (assuming 'awscli' installed with Homebrew)
# https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-completion.html#cli-command-completion-linux
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
complete -C "$HOMEBREW_PREFIX/bin/aws_completer" aws

# Google Cloud SDK
# https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke
# needed when running kubectl version < 1.25
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
# brew instruction v425.0.0: "To add gcloud components to your PATH, add this to your profile"
source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"

# Source customer specific init scripts
for dir in $HOME/work/*
do
    if [ -d "$dir" ]; then
        source $dir/.zshrc
    fi
done
