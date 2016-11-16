#!/bin/bash -f

# Remove apache
brew uninstall httpd24
rm -r /usr/local/etc/apache2/2.4

# Uninstall php70
brew uninstall php70-couchbase
brew uninstall php70-event
brew uninstall php70-gearman
brew uninstall php70-geoip
brew uninstall php70-imagick
brew uninstall php70-mcrypt
brew uninstall php70-mongodb
brew uninstall php70-redis
brew uninstall php70-solr
brew uninstall php70-xdebug
brew uninstall php70

# Uninstall php56
brew uninstall php56-couchbase
brew uninstall php56-event
brew uninstall php56-gearman
brew uninstall php56-geoip
brew uninstall php56-imagick
brew uninstall php56-mcrypt
brew uninstall php56-mongodb
brew uninstall php56-redis
brew uninstall php56-solr
brew uninstall php56-xdebug
brew uninstall php56

# Remove composer
rm -f /usr/local/bin/composer