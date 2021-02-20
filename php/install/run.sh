#!/usr/bin/env bash

# This will setup apache, php74, php80.
# Reference article: https://getgrav.org/blog/macos-mojave-apache-multiple-php-versions

DIR=${BASH_SOURCE%/*}

if [ ! ${IS_COLOR_SOURCED} ]; then
    source ${DIR}/../../lib/colors.sh
fi

# Ensure openssl is installed.
brew install openssl

source ${DIR}/install_httpd.sh
source ${DIR}/install_php.sh
