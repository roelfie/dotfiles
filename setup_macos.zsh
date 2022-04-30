#!/usr/bin/env zsh
#
# Use for inspiration: https://gist.github.com/sohooo/3199249
# TODO is there official comprehensive documentation on these settings?

echo "\n<<< Starting macOS Setup >>>\n"

# Use 'Novel' theme in Terminal.app
defaults write com.apple.Terminal "Default Window Settings" -string "Novel"
defaults write com.apple.Terminal "Startup Window Settings" -string "Novel"

# Disable “natural” (Lion-style) scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Do NOT preserve formatting when copy-paste from Terminal
defaults write com.apple.Terminal CopyAttributesProfile com.apple.Terminal.no-attributes


###############################################################################
# Kill affected applications                                                  #
###############################################################################

for app in Finder Dock; do
	killall "$app" > /dev/null 2>&1
done
echo "Done. Note that some of these changes require a logout/restart to take effect."
