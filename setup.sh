#!/bin/bash -f

# PlistBuddy is a command for writing complex Plist values
PLISTBUDDY=/usr/libexec/PlistBuddy

# grant this user access to the sudo commands without passwords
# add all required cmds to the CMDS alias
sudo mkdir -p /etc/sudoers.d
sudo tee /etc/sudoers.d/$USER <<END
$USER ALL=(ALL) NOPASSWD:ALL
END

# Set some sensible defaults for Finder
# Show all hidden files by default, and restart Finder to enable.
defaults write com.apple.finder NewWindowTargetPath file://$HOME # New window starts at $HOME.
defaults write com.apple.finder AppleShowAllFiles YES
# killall -HUP Finder # too extreme to kill finder we should figure out how tor re-launch instead.

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
TERMINAL_CONF=com.apple.Terminal
TERMINAL_CONF_PATH=~/Library/Preferences/$TERMINAL_CONF.plist
$PLISTBUDDY -c "Set 'Default Window Settings' Pro" $TERMINAL_CONF_PATH
$PLISTBUDDY -c "Set 'Startup Window Settings' Pro" $TERMINAL_CONF_PATH
$PLISTBUDDY -c "Add 'Window Settings:Pro:useOptionAsMetaKey' bool YES" $TERMINAL_CONF_PATH

# Setup Common Packages
sh common.sh

# Setup bash
sh bash-setup.sh

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
