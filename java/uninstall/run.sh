#!/usr/bin/env bash


DIR=${BASH_SOURCE%/*}

if [ ! ${IS_COLOR_SOURCED} ]; then
    source ${DIR}/../../lib/colors.sh
fi

brew uninstall android-studio
brew uninstall android-sdk
brew uninstall android-ndk
brew uninstall intel-haxm
brew uninstall java