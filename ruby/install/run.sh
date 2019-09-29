#!/usr/bin/env bash

DIR=${BASH_SOURCE%/*}

if [ ! ${IS_COLOR_SOURCED} ]; then
    source ${DIR}/../../lib/colors.sh
fi

echo "${GREEN}Installing... ${BROWN}ruby...${NC}"

echo "${RED}Which ruby version manager would you like to use? (See readme for details) ${GREEN}[rbenv,rvm] default: rbenv${NC}"
read choice

case $choice in
    rvm) source ${DIR}/install_rvm.sh;;
    rbenv) source ${DIR}/install_rbenv.sh ;;
    *) source ${DIR}/install_rbenv.sh ;;
esac

gem install bundler
gem install grb
gem install cocoapods
gem install xcode-install
gem install slather
gem install xcpretty
gem install fastlane
source ${DIR}/install_rails.sh

if [[ "${choice}" == "rbenv" ]]; then
    rbenv rehash
    echo "rbenv rehashed"
fi
