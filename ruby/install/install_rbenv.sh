#!/usr/bin/env bash

DIR=${BASH_SOURCE%/*}

echo "${GREEN}Setting up... ${BROWN}rbenv...${NC}"
echo "${YELLOW}IMPORTANT: rbenv will NOT work if RVM is installed.${NC}"

brew update
brew install rbenv ruby-build

echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi # Load rbenv' >> ${HOME}/.profile
source $HOME/.profile
rbenv install 3.0.0
rbenv global 3.0.0
ruby -v
