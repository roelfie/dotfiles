#!/usr/bin/env zsh
# 
# Generate (git) workspaces for personal and work related coding projects.
# 
# This script is driven by a config file that is stored outside of this git project
# (since it contains confidential data, like company names and email addresses).
# An example config file can be found in .dotfiles/resources/workspaces.conf.yaml.
# 
# You can create additional workspaces afterwards with the 'mkws' alias.
# 
# This script uses 'yq' (https://mikefarah.gitbook.io/yq/) to parse the config yaml file.

echo "\n<<< Setup workspaces >>>\n"

WORKSPACES_PREFIX="$HOME/workspaces"
WORKSPACES_CONFIG="$HOME/Dropbox/Apps/dotfiles/workspaces.conf.yaml"
GIT_CONFIG_GLOBAL="$HOME/.gitconfig"


# Each workspace gets its own git config file (with client specific git credentials)
# https://dzone.com/articles/how-to-use-gitconfigs-includeif
# https://stackoverflow.com/questions/4220416/can-i-specify-multiple-users-for-myself-in-gitconfig/43654115#43654115
# https://stackoverflow.com/a/43654115
update_global_gitconfig() {
    WORKSPACE_NAME="$1"
    WORKSPACE="$2"

    if [ ! -f "$GIT_CONFIG_GLOBAL" ]; then
        echo "Creating file:      $GIT_CONFIG_GLOBAL"
        touch "$GIT_CONFIG_GLOBAL"
    fi

    SEARCH_STRING="/$WORKSPACE_NAME/"
    if grep -Fq "$SEARCH_STRING" "$GIT_CONFIG_GLOBAL"; then
        echo "Not updating global ~/.gitconfig. It already contains a reference to workspace '$WORKSPACE_NAME'."
    else
        echo "Updating file:     ~/.gitconfig"
        # https://git-scm.com/docs/git-config#Documentation/git-config.txt-codegitdircode
        cat <<EOF >> "$GIT_CONFIG_GLOBAL"

[includeIf "gitdir:$WORKSPACE/"]
    path = $WORKSPACE/.gitconfig
EOF
    fi
}

create_workspaces_root() {
    if [ ! -d "$WORKSPACES_PREFIX" ]; then
        echo "Creating folder:    $WORKSPACES_PREFIX"
        mkdir "$WORKSPACES_PREFIX"
    else
        echo "Folder '$WORKSPACES_PREFIX' already exists."
    fi
}

create_workspace() {
    WORKSPACE_NAME="$1"
    GIT_USER="$2"
    GIT_EMAIL="$3"
    GIT_ORG="$4"
    WORKSPACE="$WORKSPACES_PREFIX/$WORKSPACE_NAME"
    GIT_CONFIG="$WORKSPACE/.gitconfig"

    echo "\n\nCreating workspace $WORKSPACE_NAME with Git user $GIT_USER, email $GIT_EMAIL and org $GIT_ORG.\n\n" 

    if [ ! -d "$WORKSPACE" ]; then
        echo "Creating folder:    $WORKSPACE"
        mkdir "$WORKSPACE"

        echo "Cloning repositories ..."
        cd "$WORKSPACE"
        gh repo list "$GIT_ORG" | while read -r repo _; do
            printf "\n\n\n\n"
            git clone git@github.com:$repo.git
        done
        cd ..
        echo "\nAll repositories have been cloned into $WORKSPACE."
        echo "Remove any repositories that you don't need now.\n\n"
        vared -p "Press [Enter] when done. " -c REPLY

        echo "Creating gitconfig: $GIT_CONFIG"
        cat <<EOF > "$GIT_CONFIG"
[user] 
    name = $GIT_USER
    email = $GIT_EMAIL
EOF
        update_global_gitconfig $WORKSPACE_NAME $WORKSPACE
    else
        echo "Workspace '$WORKSPACE_NAME' already exists."
    fi
}


create_workspaces_root
# Read items from a list with yq; no idea how this works but it works...
# https://stackoverflow.com/questions/62898925/using-yq-in-for-loop-bash 
# https://stackoverflow.com/a/70841936
while IFS=$'\t' read -r name git_username git_email git_org _; do
    echo "\n[$name]"
    create_workspace $name $git_username $git_email $git_org
done < <(yq e '.workspaces[] | [.name, .git.username, .git.email, .git.org] | @tsv' $WORKSPACES_CONFIG)

