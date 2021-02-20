#!/usr/bin/env bash

# Common
cp ${DIR}/stubs/info.php ${HOME}/Sites/info.php

# sphp
echo "${GREEN}Installing... ${BROWN}sphp script...${NC}"
curl -L https://gist.githubusercontent.com/rhukster/f4c04f1bf59e0b74e335ee5d186a98e2/raw/0c36a5067fbd63e6a36700a6aaa119df0836bdfc/sphp.sh > /usr/local/bin/sphp
chmod +x /usr/local/bin/sphp

# Use @see https://github.com/shivammathur/homebrew-php for php setups.
brew tap shivammathur/php

brew install shivammathur/php/php@7.4
brew install shivammathur/php/php@8.0
sphp 8.0

# Get Composer
echo "${GREEN}Installing... ${BROWN}composer...${NC}"
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin
mv /usr/local/bin/composer.phar /usr/local/bin/composer

# Finish
sudo apachectl -k restart

open http://localhost/info.php
