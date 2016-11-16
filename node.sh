#!/bin/bash -f

# We'll need our username
USERNAME=`whoami`

# Set up Node.js
NODE_INSTALL_VERSION=$(wget -qO- https://nodejs.org/dist/latest/ | sed -nE 's|.*>node-(.*)\.pkg</a>.*|\1|p')
curl "https://nodejs.org/dist/latest/node-${NODE_INSTALL_VERSION}.pkg" > "$HOME/Downloads/node-latest.pkg"
sudo installer -store -pkg "$HOME/Downloads/node-latest.pkg" -target "/"
rm $HOME/Downloads/node-latest.pkg

# Fix permissions
sudo chown -R $USERNAME:staff /usr/local

# Setup N to manage multiple node versions.
npm install -g n

# Now install new nodes through n...
n lts
n stable
n latest

# Packagers & Build tools
npm install -g webpack nodemon

# Testing related
npm install -g mocha karma-cli eslint raml-cop

# Frameworks
npm install -g express-generator angular-cli

# Misc
npm install -g http-server

# Optional: commented out to save time, but if you want to install just run below:
# npm install -g gatsby react-native-cli ember-cli yo gulp-cli grunt-cli bower swagger