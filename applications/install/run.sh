#!/usr/bin/env bash

# This will setup node, yarn, and some goodies.

DIR=${BASH_SOURCE%/*}

if [ ! ${IS_COLOR_SOURCED} ]; then
    source ${DIR}/../../lib/colors.sh
fi

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

brew cask install slack
brew cask install sequel-pro
brew cask install jetbrains-toolbox
brew cask install visual-studio-code
brew cask install zeplin
brew cask install postico
brew cask install docker
brew cask install handbrake
brew cask install postman
brew cask install google-chrome
brew cask install firefox
brew cask install appium
brew cask install charles
brew cask install sublime-text
