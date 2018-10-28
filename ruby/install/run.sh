#!/usr/bin/env bash

DIR=${BASH_SOURCE%/*}

if [ ! ${IS_COLOR_SOURCED} ]; then
    source ${DIR}/../../lib/colors.sh
fi

echo "${GREEN}Installing... ${BROWN}ruby...${NC}"
sudo gem install grb --no-document
