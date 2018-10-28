#!/usr/bin/env bash


DIR=${BASH_SOURCE%/*}

if [ ! ${IS_COLOR_SOURCED} ]; then
    source ${DIR}/../../lib/colors.sh
fi

echo "${RED}Uninstalling... ${BROWN}Nodejs...${NC}"
yarn global remove n
yarn global remove create-react-app
yarn global remove jest

brew uninstall yarn

sudo n prune

rm -r /usr/local/n
rm -r /usr/local/lib/node_modules/
rm -r /usr/local/include/node/
