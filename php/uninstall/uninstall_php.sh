#!/usr/bin/env bash

echo "${RED}Uninstalling... ${BROWN}php@5.6...${NC}"
brew uninstall php@5.6

# 7.0
echo "${RED}Uninstalling... ${BROWN}php@7.0...${NC}"
brew uninstall php@7.0
mv /usr/local/etc/php/7.0/conf.d/ext-imagick.ini /usr/local/etc/php/7.0/conf.d/ext-imagick.ini.bak 2>/dev/null; true
mv /usr/local/etc/php/7.0/conf.d/ext-xdebug.ini /usr/local/etc/php/7.0/conf.d/ext-xdebug.ini.bak 2>/dev/null; true
mv /usr/local/etc/php/7.0/conf.d/ext-yaml.ini /usr/local/etc/php/7.0/conf.d/ext-yaml.ini.bak 2>/dev/null; true

# 7.1
echo "${RED}Uninstalling... ${BROWN}php@7.1...${NC}"
brew uninstall php@7.1
mv /usr/local/etc/php/7.1/conf.d/ext-imagick.ini /usr/local/etc/php/7.1/conf.d/ext-imagick.ini.bak 2>/dev/null; true
mv /usr/local/etc/php/7.1/conf.d/ext-xdebug.ini /usr/local/etc/php/7.1/conf.d/ext-xdebug.ini.bak 2>/dev/null; true
mv /usr/local/etc/php/7.1/conf.d/ext-yaml.ini /usr/local/etc/php/7.1/conf.d/ext-yaml.ini.bak 2>/dev/null; true

# 7.2
echo "${RED}Uninstalling... ${BROWN}php@7.2...${NC}"
brew uninstall php@7.2
mv /usr/local/etc/php/7.2/conf.d/ext-imagick.ini /usr/local/etc/php/7.2/conf.d/ext-imagick.ini.bak 2>/dev/null; true
mv /usr/local/etc/php/7.2/conf.d/ext-xdebug.ini /usr/local/etc/php/7.2/conf.d/ext-xdebug.ini.bak 2>/dev/null; true
mv /usr/local/etc/php/7.2/conf.d/ext-yaml.ini /usr/local/etc/php/7.2/conf.d/ext-yaml.ini.bak 2>/dev/null; true
php -v

sed "s~\\\$\\\$USER\\\$\\\$~${USER}~g" ${DIR}/../install/stubs/httpd.conf.stub > /usr/local/etc/httpd/httpd.conf

# Remove composer
rm -f /usr/local/bin/composer

sudo apachectl -k restart
