#!/usr/bin/env bash

DIR=${BASH_SOURCE%/*}

if [ ! ${IS_COLOR_SOURCED} ]; then
    source ${DIR}/../../lib/colors.sh
fi

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

brew cask install java
brew cask install android-sdk
brew cask install android-ndk
brew cask install intel-haxm
brew cask install android-studio