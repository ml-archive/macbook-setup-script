#!/usr/bin/env bash

# Common
cp ${DIR}/stubs/info.php ${HOME}/Sites/info.php

# sphp
echo "${GREEN}Installing... ${BROWN}sphp script...${NC}"
curl -L https://gist.githubusercontent.com/rhukster/f4c04f1bf59e0b74e335ee5d186a98e2/raw > /usr/local/bin/sphp
chmod +x /usr/local/bin/sphp


# PHP 5.6
echo "${GREEN}Installing... ${BROWN}php@5.6...${NC}"
brew install php@5.6
cp ${DIR}/stubs/ext-opcache.ini /usr/local/etc/php/5.6/conf.d/ext-opcache.ini # Avoid seg fault from opcache see: https://discourse.brew.sh/t/segmentation-fault-on-mojave-http24-php56/3043/7


# PHP 7.0
echo "${GREEN}Installing... ${BROWN}php@7.0...${NC}"
brew install php@7.0
sphp 7.0
pecl uninstall -r yaml # Insure it's a fresh pecl install
pecl uninstall -r xdebug # Insure it's a fresh pecl install
pecl uninstall -r imagick # Insure it's a fresh pecl install
printf "\n" | pecl install yaml
printf "\n" | pecl install xdebug
printf "\n" | pecl install imagick
perl -i -0pe "s~extension=\"imagick.so\"\n~~g" /usr/local/etc/php/7.0/php.ini
perl -i -0pe "s~zend_extension=\"xdebug.so\"\n~~g" /usr/local/etc/php/7.0/php.ini
perl -i -0pe "s~extension=\"yaml.so\"\n~~g" /usr/local/etc/php/7.0/php.ini
cp php/install/stubs/ext-imagick.ini /usr/local/etc/php/7.0/conf.d/ext-imagick.ini
cp php/install/stubs/ext-xdebug.ini /usr/local/etc/php/7.0/conf.d/ext-xdebug.ini
cp php/install/stubs/ext-yaml.ini /usr/local/etc/php/7.0/conf.d/ext-yaml.ini


# PHP 7.1
echo "${GREEN}Installing... ${BROWN}php@7.1...${NC}"
brew install php@7.1
sphp 7.1
pecl uninstall -r yaml # Insure it's a fresh pecl install
pecl uninstall -r xdebug # Insure it's a fresh pecl install
pecl uninstall -r imagick # Insure it's a fresh pecl install
printf "\n" | pecl install yaml
printf "\n" | pecl install xdebug
printf "\n" | pecl install imagick
perl -i -0pe "s~extension=\"imagick.so\"\n~~g" /usr/local/etc/php/7.1/php.ini
perl -i -0pe "s~zend_extension=\"xdebug.so\"\n~~g" /usr/local/etc/php/7.1/php.ini
perl -i -0pe "s~extension=\"yaml.so\"\n~~g" /usr/local/etc/php/7.1/php.ini
cp php/install/stubs/ext-imagick.ini /usr/local/etc/php/7.1/conf.d/ext-imagick.ini
cp php/install/stubs/ext-xdebug.ini /usr/local/etc/php/7.1/conf.d/ext-xdebug.ini
cp php/install/stubs/ext-yaml.ini /usr/local/etc/php/7.1/conf.d/ext-yaml.ini


# PHP 7.2
echo "${GREEN}Installing... ${BROWN}php@7.2...${NC}"
brew install php@7.2
sphp 7.2
pecl uninstall -r yaml # Insure it's a fresh pecl install
pecl uninstall -r xdebug # Insure it's a fresh pecl install
pecl uninstall -r imagick # Insure it's a fresh pecl install
printf "\n" | pecl install yaml
printf "\n" | pecl install xdebug
printf "\n" | pecl install imagick
perl -i -0pe "s~extension=\"imagick.so\"\n~~g" /usr/local/etc/php/7.2/php.ini
perl -i -0pe "s~zend_extension=\"xdebug.so\"\n~~g" /usr/local/etc/php/7.2/php.ini
perl -i -0pe "s~extension=\"yaml.so\"\n~~g" /usr/local/etc/php/7.2/php.ini
cp php/install/stubs/ext-imagick.ini /usr/local/etc/php/7.2/conf.d/ext-imagick.ini
cp php/install/stubs/ext-xdebug.ini /usr/local/etc/php/7.2/conf.d/ext-xdebug.ini
cp php/install/stubs/ext-yaml.ini /usr/local/etc/php/7.2/conf.d/ext-yaml.ini

# Get Composer
echo "${GREEN}Installing... ${BROWN}composer...${NC}"
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin
mv /usr/local/bin/composer.phar /usr/local/bin/composer

# Finish
sudo apachectl -k restart

open http://localhost/info.php
