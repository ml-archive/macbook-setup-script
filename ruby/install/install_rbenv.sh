#!/usr/bin/env bash

DIR=${BASH_SOURCE%/*}

echo "${GREEN}Setting up... ${BROWN}rbenv...${NC}"
echo "${YELLOW}IMPORTANT: rbenv will NOT work if RVM is installed.${NC}"

brew update
brew install rbenv ruby-build

echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi # Load rbenv' >> ${HOME}/.bash_profile
source $HOME/.bash_profile
rbenv install 2.6.3
rbenv global 2.6.3
ruby -v
