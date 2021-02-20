#!/usr/bin/env bash

# 7.4
echo "${RED}Uninstalling... ${BROWN}php@7.4...${NC}"
brew uninstall shivammathur/php/php@7.4
php -v

# 8.0
echo "${RED}Uninstalling... ${BROWN}php@8.0...${NC}"
brew uninstall shivammathur/php/php@8.0
php -v

sed "s~\\\$\\\$USER\\\$\\\$~${USER}~g" ${DIR}/../install/stubs/httpd.conf.stub > /usr/local/etc/httpd/httpd.conf

# Remove composer & sphp
rm -f /usr/local/bin/sphp
rm -f /usr/local/bin/composer

sudo apachectl -k restart
