#!/usr/bin/env zsh
#
# Assuming the jdk(s) and jenv are already installed with Homebrew, we still have to tell jenv what jdk(s) exist.

echo "\n<<< Setup jEnv >>>\n"

JAVA_HOME_LOCATIONS=(
    /Library/Java/JavaVirtualMachines/jdk-18.0.1.1.jdk/Contents/Home
)

for location in ${JAVA_HOME_LOCATIONS[@]}; do
    jenv add $location
done

echo "jEnv setup complete. The following Java versions are available with jEnv:"
jenv versions
vared -p "Press [Enter] to continue. " -c REPLY
