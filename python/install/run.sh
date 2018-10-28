#!/usr/bin/env bash

DIR=${BASH_SOURCE%/*}

if [ ! ${IS_COLOR_SOURCED} ]; then
    source ${DIR}/../../lib/colors.sh
fi

echo "${GREEN}Installing... ${BROWN}python...${NC}"
brew install python python@2
pip3 install awscli
pip3 install awsebcli
pip3 install virtualenv
