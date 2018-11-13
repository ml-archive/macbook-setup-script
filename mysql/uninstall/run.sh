#!/usr/bin/env bash


DIR=${BASH_SOURCE%/*}

if [ ! ${IS_COLOR_SOURCED} ]; then
    source ${DIR}/../../lib/colors.sh
fi

brew services stop mysql
brew uninstall mysql
# rm -rf /usr/local/var/mysql # -- WARNING THIS WILL DELETE ALL DATABASES!!


# The uninstall for mysql@5.7
#brew services stop mysql@5.7
#brew uninstall mysql@5.7
## rm -rf /usr/local/var/mysql # -- WARNING THIS WILL DELETE ALL DATABASES!!
