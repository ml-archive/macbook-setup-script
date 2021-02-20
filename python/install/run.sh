#!/usr/bin/env bash

DIR=${BASH_SOURCE%/*}

if [ ! ${IS_COLOR_SOURCED} ]; then
    source ${DIR}/../../lib/colors.sh
fi

echo "${GREEN}Installing... ${BROWN}python...${NC}"
brew update
brew install pyenv
brew install pipx
pipx ensurepath
pipx completions
pyenv install 3.9.1
pyenv global 3.9.1
pipx install virtualenv
