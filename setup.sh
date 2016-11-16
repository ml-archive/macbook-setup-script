#!/bin/bash -f

# Function to check if a function exists...
fn_exists()
{
    type $1 2>/dev/null | grep -q 'is a function'
}

# Echo in a fancy way...
fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\n$fmt\n" "$@"
}

# PlistBuddy is a command for writing complex Plist values
PLISTBUDDY=/usr/libexec/PlistBuddy

# We'll need our username
USERNAME=`whoami`

# Set hostname to localhost
sudo scutil --set HostName localhost

# grant this user access to the sudo commands without passwords
# add all required cmds to the CMDS alias
sudo tee /etc/sudoers.d/$USER <<END
$USER $(hostname) = NOPASSWD: rm, tee, apachectl, launchctl, brew, sed, touch, easy_install, pip, installer, mkdir, cp, chown
END

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

TAB_KEY_SYMBOL="\\U21e5" # Note the backslash-escaped backslash.
COMMAND_KEY_SYMBOL="@"
SHIFT_KEY_SYMBOL="$"
CONTROL_KEY_SYMBOL="^"

# Setup hotkeys for terminal tab switching.
defaults write -app Terminal NSUserKeyEquivalents "{
	 'Show Next Tab' = '${CONTROL_KEY_SYMBOL}${TAB_KEY_SYMBOL}';
     'Show Previous Tab' = '${CONTROL_KEY_SYMBOL}${SHIFT_KEY_SYMBOL}${TAB_KEY_SYMBOL}';
}"

# Setup Common Packages
sh common.sh

# Setup bash
sh bash-setup.sh

# Setup PHP & Apache
sh php-apache.sh

# Setup node
sh node.sh

# Setup Python Packages
sh python.sh

# Setup Ruby Packages
sh ruby.sh

# Setup Swift Stuff
sh swift.sh

# then, remove the sudo access
sudo rm /etc/sudoers.d/$USER
sudo -k