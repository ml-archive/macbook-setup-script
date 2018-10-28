#!/usr/bin/env bash

echo "${RED}Uninstalling ${YELLOW}httpd...${NC}"

apachectl -k stop
brew services stop httpd && sleep .5


# If you're wondering what is and how launchctl works I recommend reading: http://www.launchd.info/

brew uninstall httpd

mv /usr/local/etc/httpd/httpd.conf /usr/local/etc/httpd/httpd.conf.uninstalled 2>/dev/null; true
mv /usr/local/etc/httpd/sites.conf /usr/local/etc/httpd/sites.conf.uninstalled 2>/dev/null; true
