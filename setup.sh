#!/bin/bash -f

# grant this user access to the sudo commands without passwords
# add all required cmds to the CMDS alias
sudo mkdir -p /etc/sudoers.d
sudo tee /etc/sudoers.d/$USER <<END
$USER ALL=(ALL) NOPASSWD:ALL
END

# Set some sensible defaults for Finder
# Show all hidden files by default, and restart Finder to enable.
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath file://$HOME # New window starts at $HOME.
defaults write com.apple.finder AppleShowAllFiles YES
# killall -HUP Finder # too extreme to kill finder we should figure out how tor re-launch instead.

# Some other defaults
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

# Set hostname to localhost
sudo scutil --set HostName localhost

# Make a basic .emacs file
echo '; highlighting should work
(transient-mark-mode 1)
; put backups in /tmp
(setq backup-directory-alist
`((".*" . ,temporary-file-directory)))
; put autosaves in /tmp
(setq auto-save-file-name-transforms
`((".*" ,temporary-file-directory t)))
' > ~/.emacs

# Set some good default terminal settings
TERMINAL_CONF_PATH=~/Library/Preferences/com.apple.Terminal.plist
/usr/libexec/PlistBuddy -c "Set 'Default Window Settings' Novel" $TERMINAL_CONF_PATH
/usr/libexec/PlistBuddy -c "Set 'Startup Window Settings' Novel" $TERMINAL_CONF_PATH
/usr/libexec/PlistBuddy -c "Add :Window\ Settings:Novel:useOptionAsMetaKey bool true" $TERMINAL_CONF_PATH

# Setup Common Packages
sh common.sh

# Setup terminal both for bash and zsh.
sh terminal-setup.sh

# Run if you want to use bash instead of zsh.
#sh use-bash.sh

# Setup Common Applications
sh applications/install/run.sh

# Setup Java Environment
sh java/install/run.sh

# Setup Common Packages
sh mysql/install/run.sh

# Setup PHP & Apache
sh php/install/run.sh

# Setup node
sh node/install/run.sh

# Setup Python Packages
sh python/install/run.sh

# Setup Ruby Packages
sh ruby/install/run.sh

# Setup Ruby Packages
sh go/install/run.sh

# then, remove the sudo access
sudo rm /etc/sudoers.d/$USER
sudo -k
