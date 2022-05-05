#!/usr/bin/env zsh

echo "\n<<< Starting JDK Setup >>>\n"

JAVA_HOME_LOCATIONS=(
    /Library/Java/JavaVirtualMachines/jdk-18.0.1.1.jdk/Contents/Home
)

# Assuming the jdk(s) and jenv are already installed with Homebrew, we still have to tell jenv what jdk(s) exist.

# jenv setup
if grep -Fxq ".jenv/bin" '~/.zshrc'; then
    vared -p "~/.jenv/bin probably already added to PATH. Please check / fix manually in ~/.zshrc (see setup_java.zsh for details). Press [Enter] when done. " -c REPLY
else
    echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> ~/.zshrc
fi

if grep -Fxq "jenv()" '~/.zshrc'; then
    vared -p "jenv() function probably already added to .zshrc. Please check / fix manually in ~/.zshrc (see setup_java.zsh for details). Press [Enter] when done. " -c REPLY
else
    echo 'eval "$(jenv init -)"' >> ~/.zshrc
fi

# jenv configuration
for location in ${JAVA_HOME_LOCATIONS[@]}; do
    jenv add $location
done

echo "jEnv setup complete. The following Java versions are available with jEnv:"
jenv versions
vared -p "Press [Enter] to continue. " -c REPLY
