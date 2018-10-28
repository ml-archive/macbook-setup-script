#!/usr/bin/env bash

# This will setup apache, php56, php70, php72 and is intended to work on Mojave.
# Reference article: https://getgrav.org/blog/macos-mojave-apache-multiple-php-versions

DIR=${BASH_SOURCE%/*}

if [ ! ${IS_COLOR_SOURCED} ]; then
    source ${DIR}/../../lib/colors.sh
fi

echo "${GREEN}Installing... ${BROWN}openldap & libiconv & libyaml...${NC}"
brew install openldap libiconv libyaml

source ${DIR}/install_httpd.sh
source ${DIR}/install_php.sh
