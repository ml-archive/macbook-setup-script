#!/bin/bash -f

# Remove apache
brew uninstall httpd24
rm -r /usr/local/etc/apache2/2.4

# Uninstall php70
brew uninstall php70

# Uninstall php56
brew uninstall php56

# Remove composer
rm -f /usr/local/bin/composer