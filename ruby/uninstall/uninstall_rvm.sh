#!/usr/bin/env bash

echo "${RED}Uninstalling ${YELLOW}rvm...${NC}"

printf "yes\n" | rvm implode
rm -rf ${HOME}/.rvm
rm -f ${HOME}/.rvmrc
sudo rm -f /etc/profile.d/rvm.sh
sudo rm -f /etc/rvmrc

grep -vi 'rvm' ${HOME}/.bash_profile > temp && mv temp ${HOME}/.bash_profile

gpg --batch --yes --delete-key piotr.kuczynski@gmail.com
gpg --batch --yes --delete-key mpapis@gmail.com
