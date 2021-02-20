#!/usr/bin/env bash

# This will setup node, yarn, and some goodies.

DIR=${BASH_SOURCE%/*}

if [ ! ${IS_COLOR_SOURCED} ]; then
    source ${DIR}/../../lib/colors.sh
fi

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

brew install slack --cask
brew install sequel-pro --cask
brew install jetbrains-toolbox --cask
brew install visual-studio-code --cask
brew install postico --cask
brew install tableplus --cask
brew install docker --cask
brew install handbrake --cask
brew install postman --cask
brew install google-chrome --cask
