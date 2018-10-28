#!/usr/bin/env bash

echo "${GREEN}Installing... ${BROWN}httpd...${NC}"

sudo apachectl stop
sudo launchctl unload -w /System/Library/LaunchDaemons/org.apache.httpd.plist 2>/dev/null; true
# If you're wondering what is and how launchctl works I recommend reading: http://www.launchd.info/

brew install httpd

brew services start httpd

# Now that brew has finished with installing we will setup the config file.

# Check that httpd is where we expect it, if it is not something is wrong and we shouldn't continue.
# The likely cause of this is the script is most likely outdated.
if [ ! -d /usr/local/etc/httpd ]; then
    echo "${RED}httpd was not found in the expected directory!${NC}"
    echo "${RED}This script depends on httpd.conf to be loaded in from /usr/local/etc/httpd ${NC}"
    exit 1;
fi

echo "${BROWN}Setting up httpd.conf...${NC}"
mv /usr/local/etc/httpd/httpd.conf /usr/local/etc/httpd/httpd.conf.bak 2>/dev/null; true
sed "s~\\\$\\\$USER\\\$\\\$~${USER}~g" ${DIR}/stubs/httpd.conf.stub > /usr/local/etc/httpd/httpd.conf

if [ ! -f /usr/local/etc/httpd/sites.conf ]; then
    echo "${BROWN}Setting up sites.conf...${NC}"
    sed "s~\\\$\\\$USER\\\$\\\$~${USER}~g" ${DIR}/stubs/sites.conf.stub > /usr/local/etc/httpd/sites.conf
fi

# Get the server root from the stub. should be: /usr/local/opt/httpd
SERVER_ROOT_DIR=$(grep ^ServerRoot php/install/stubs/httpd.conf.stub | grep -o '[^ServerRoot \"][a-z/]*')

# Check to ensure LoadModule rewrite_module lib/httpd/modules/mod_rewrite.so
if [ ! -f ${SERVER_ROOT_DIR}/lib/httpd/modules/mod_rewrite.so ]; then
    echo "${RED}${SERVER_ROOT_DIR}/lib/httpd/modules/mod_rewrite.so could not be found.${NC}"
    echo "${RED}It is required for rewrite_module, httpd will not work without it or you must disable: LoadModule rewrite_module in httpd.conf${NC}"
fi

# Check to ensure LoadModule vhost_alias_module lib/httpd/modules/mod_vhost_alias.so will work
if [ ! -f ${SERVER_ROOT_DIR}/lib/httpd/modules/mod_vhost_alias.so ]; then
    echo "${RED} ${SERVER_ROOT_DIR}/lib/httpd/modules/mod_vhost_alias.so could not be found.${NC}"
    echo "${RED} It is required for vhost_alias_module, httpd will not work without it or you must disable: LoadModule vhost_alias_module in httpd.conf${NC}"
fi

brew services restart httpd && sleep .5

cp ${DIR}/stubs/index.html ${HOME}/Sites/index.html

echo "${GREEN} $(curl --silent localhost)${NC}"
