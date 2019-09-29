#!/usr/bin/env bash

echo "${RED}Uninstalling ${YELLOW}rbenv...${NC}"

rm -rf `rbenv root`
brew uninstall rbenv ruby-build
grep -vi 'rbenv' ${HOME}/.bash_profile > temp && mv temp ${HOME}/.bash_profile
