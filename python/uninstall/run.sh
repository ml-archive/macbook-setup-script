#!/usr/bin/env bash


DIR=${BASH_SOURCE%/*}

if [ ! ${IS_COLOR_SOURCED} ]; then
    source ${DIR}/../../lib/colors.sh
fi

pipx uninstall virtualenv
pyenv global system
printf "y\n" | pyenv uninstall 3.9.1
brew uninstall pipx
brew uninstall pyenv
