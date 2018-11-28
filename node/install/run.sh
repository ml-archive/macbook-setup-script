#!/usr/bin/env bash

# This will setup node, yarn, and some goodies.

DIR=${BASH_SOURCE%/*}

if [ ! ${IS_COLOR_SOURCED} ]; then
    source ${DIR}/../../lib/colors.sh
fi

# Set up Node.js
echo "${GREEN}Installing... ${BROWN}Nodejs...${NC}"
brew install node


echo "${GREEN}Installing... ${BROWN}yarn...${NC}"
brew install yarn

yarn global add n --prefix /usr/local
yarn global add create-react-app --prefix /usr/local
yarn global add jest

sudo n lts
sudo n stable
sudo n latest
