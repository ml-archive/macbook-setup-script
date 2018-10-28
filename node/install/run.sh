#!/usr/bin/env bash

# This will setup node, yarn, and some goodies.

DIR=${BASH_SOURCE%/*}

if [ ! ${IS_COLOR_SOURCED} ]; then
    source ${DIR}/../../lib/colors.sh
fi

# Set up Node.js
echo "${GREEN}Installing... ${BROWN}Nodejs...${NC}"
NODE_INSTALL_VERSION=$(wget -qO- https://nodejs.org/dist/latest/ | sed -nE 's|.*>node-(.*)\.pkg</a>.*|\1|p')
curl "https://nodejs.org/dist/latest/node-${NODE_INSTALL_VERSION}.pkg" > "$HOME/Downloads/node-latest.pkg"
sudo installer -store -pkg "$HOME/Downloads/node-latest.pkg" -target "/"
rm $HOME/Downloads/node-latest.pkg


echo "${GREEN}Installing... ${BROWN}yarn...${NC}"
brew install yarn

yarn global add n --prefix /usr/local
yarn global add create-react-app --prefix /usr/local
yarn global add jest

sudo n lts
sudo n stable
sudo n latest
