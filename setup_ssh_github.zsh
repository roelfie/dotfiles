#!/usr/bin/env zsh
# 
# Generate new SSH key pair;
# Upload public key to GitHub & check SSH connection
#
# https://docs.github.com/en/authentication/connecting-to-github-with-ssh/checking-for-existing-ssh-keys
# https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent


echo "\n<<< Generate ssh key pair >>>\n"

KEY_TYPE=ed25519
KEY_FILE=~/.ssh/id_ed25519_github
CONFIG_FILE=~/.ssh/config
EMAIL=58694687+roelfie@users.noreply.github.com

# Check for existing keys
if ls ~/.ssh/id_* 1> /dev/null 2>&1; then
    vared -p "SSH key(s) found in ~/.ssh. NOT generating new key pair. NOT uploading public key to GitHub. Press [Enter] to continue. " -c REPLY
fi

# Generate new key pair
echo "Generating ssh key pair for email $EMAIL"
ssh-keygen -t $KEY_TYPE -f $KEY_FILE -N "" -C $EMAIL

# Add new key to ssh config
if [ ! -f $CONFIG_FILE ]; then
    echo "Creating new file: $CONFIG_FILE"
    touch $CONFIG_FILE
else 
    vared -p "~/.ssh/config already exists. NOT modifying it. NOT uploading public key to GitHub. Press [Enter] to continue. " -c REPLY
fi

cat <<EOM >$CONFIG_FILE
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519_github
EOM

# Start ssh-agent
# https://apple.stackexchange.com/questions/10428/check-if-a-process-is-running-if-not-execute-it-again-in-terminal
SSH_AGENT_PROC=`ps A | grep ssh-agent | grep -v grep | grep -v usr`
if [ "$?" -ne "0" ]; then
    echo "Starting ssh-agent"
    eval "$(ssh-agent -s)"
fi

echo "Adding new key to OSX keychain"
ssh-add --apple-use-keychain $KEY_FILE



echo "\n<<< Upload public key to GitHub >>>\n"

printf "\nBefore the GitHub CLI can upload your public key, it will ask you to authenticate. Proceed as follows:\n\n"
echo "-------"
echo "STEP 1: authentication"
echo "        Re-authenticate?                                 Yes   (if applicable)"
echo "        Preferred protocol for Git operations?           HTTPS"
echo "        Authenticate Git with your GitHub credentials?   No"
echo "        How would you like to authenticate GitHub CLI?   Login with a web browser"
echo "        <<login via web browser with supplied one-time code>>"
echo "STEP 2: upload public key"
echo "        Authenticate Git with your GitHub credentials?   No"
echo "        <<login via web browser with supplied one-time code>>"
echo "-------"
vared -p "Press [Enter] to continue. " -c REPLY

# During the initial GitHub CLI authentication we choose 'preferred protocol for Git operations' = HTTPS
# to prevent the public key from being uploaded (silently) to GitHub as part of the authentication process.
# First we authenticate the CLI, then (in a separate step) we upload the public key.
# Once both steps have succeeded we will change the preferred protocol back to SSH.

echo "\nAUTHENTICATE CLI\n\n"
gh auth login
gh auth refresh -h github.com -s admin:public_key

echo "\nUPLOAD KEY\n\n"
gh ssh-key add "$KEY_FILE.pub" --title "mbp2021"
gh config set git_protocol ssh --host github.com

# check that we can establish an SSH connection to github
echo ""
ssh -T git@github.com
vared -p "SSH / GitHub configuration finished. Press [Enter] to continue. " -c REPLY
