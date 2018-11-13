#!/usr/bin/env bash

# This will setup the latest mysql. However note the latest mysql as of 2018-11-13 has issues with Sequel Pro.
# For that reason below is included in comments how to setup mysql@5.7.

DIR=${BASH_SOURCE%/*}

if [ ! ${IS_COLOR_SOURCED} ]; then
    source ${DIR}/../../lib/colors.sh
fi

echo "${GREEN}Installing... ${BROWN}mysql...${NC}"
brew install mysql
brew services start mysql

# MySql 8.* fix for Sequel Pro.
# See: https://stackoverflow.com/questions/49194719/authentication-plugin-caching-sha2-password-cannot-be-loaded
mysql -u root --password= -e "ALTER USER root@localhost IDENTIFIED WITH mysql_native_password BY ''"


# NOTE: If you've installed the latest mysql and are trying to switch to 5.7 you likely will need
# to delete the /usr/local/var/mysql folder if your seeing errors.
#brew install mysql@5.7
#brew link mysql@5.7 --force
#brew services start mysql@5.7
