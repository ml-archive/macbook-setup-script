#!/usr/bin/env bash

# This will setup go.

DIR=${BASH_SOURCE%/*}

if [ ! ${IS_COLOR_SOURCED} ]; then
    source ${DIR}/../../lib/colors.sh
fi

echo "${GREEN}Installing... ${BROWN}go...${NC}"

brew install go
go get -u golang.org/x/lint/golint
