#!/bin/bash -f

# PlistBuddy is a command for writing complex Plist values
PLISTBUDDY=/usr/libexec/PlistBuddy

# We'll need our username
USERNAME=`whoami`

# Work out of a temp directory
cd /tmp

# Make a basic .emacs file
echo '; highlighting should work
(transient-mark-mode 1)
; put backups in /tmp
(setq backup-directory-alist
`((".*" . ,temporary-file-directory)))
; put autosaves in /tmp
(setq auto-save-file-name-transforms
`((".*" ,temporary-file-directory t)))
' > ~/.emacs

# Set some good default terminal settings
TERMINAL_CONF=com.apple.Terminal
TERMINAL_CONF_PATH=~/Library/Preferences/$TERMINAL_CONF.plist
$PLISTBUDDY -c "Set 'Default Window Settings' Pro" $TERMINAL_CONF_PATH
$PLISTBUDDY -c "Set 'Startup Window Settings' Pro" $TERMINAL_CONF_PATH
$PLISTBUDDY -c "Add 'Window Settings:Pro:useOptionAsMetaKey' bool YES" $TERMINAL_CONF_PATH
defaults read com.apple.Terminal

# Set up a key binding for Zoom
defaults write -g NSUserKeyEquivalents '{
  "Zoom"="@$m";
}'
defaults read -g NSUserKeyEquivalents

# Install Xcode command line tools
xcode-select --install

# Install Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor
brew install wget

# Set up pip and AWS CLI
sudo easy_install pip
sudo pip install awscli

# Give /usr/local normal permissions
sudo chown -R $USERNAME:staff /usr/local

# Get Composer
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin
mv /usr/local/bin/composer.phar /usr/local/bin/composer

# Set up XQuartz
wget http://xquartz.macosforge.org/downloads/SL/XQuartz-2.7.7.dmg
hdiutil mount XQuartz-2.7.7.dmg
sudo installer -package /Volumes/XQuartz-2.7.7/XQuartz.pkg -target "/Volumes/Macintosh HD"
hdiutil unmount /Volumes/XQuartz-2.7.7
rm XQuartz-2.7.7.dmg

# Set up some Homebrew packages
brew install ImageMagick
brew install ghostscript
brew install autoconf
brew install mysql
brew install redis
brew install beanstalkd
brew install poppler
brew install mcrypt
brew install pkg-config
brew install pcre
brew install dnsmasq

# Make hosting environment
mkdir -p ~/Sites/laravel

# Get PHP source code to install modules
PHP_VERSION=`php -r 'echo PHP_VERSION;'`
wget http://php.net/get/php-$PHP_VERSION.tar.gz/from/this/mirror
tar xvzf mirror
rm -r mirror
cd php-$PHP_VERSION/ext/mcrypt
phpize
./configure
make
sudo make install
cd ../pcntl
phpize
./configure
make
sudo make install
cd ../../..
rm mirror

# Set up standard Apache config
sudo sed -i "" "s~#LoadModule vhost_alias_module~LoadModule vhost_alias_module~g" /etc/apache2/httpd.conf
sudo sed -i "" "s~#LoadModule rewrite_module~LoadModule rewrite_module~g" /etc/apache2/httpd.conf
sudo sed -i "" "s~#LoadModule php5_module~LoadModule php5_module~g" /etc/apache2/httpd.conf
sudo sed -i "" "s~User _www~User $USERNAME~g" /etc/apache2/httpd.conf
sudo sed -i "" "s~Group _www~Group staff~g" /etc/apache2/httpd.conf
sudo sed -i "" s~/Library/WebServer/Documents~/Users/$USERNAME/Sites~g /etc/apache2/httpd.conf
sudo sed -i "" s~"AllowOverride None"~"AllowOverride all"~g /etc/apache2/httpd.conf
echo "Include /private/etc/apache2/sites.conf" | sudo tee -a /etc/apache2/httpd.conf
sudo touch /etc/apache2/sites.conf
sudo tee /etc/apache2/sites.conf >/dev/null <<'EOF'
# Workaround for missing Authorization header under CGI/FastCGI Apache:
<IfModule setenvif_module>
  SetEnvIf Authorization .+ HTTP_AUTHORIZATION=$0
</IfModule>

EOF

sudo tee -a /etc/apache2/sites.conf >/dev/null <<EOF
# Serve ~/Sites at http://localhost
ServerName localhost

<VirtualHost *:80>
  ServerName localhost
  DocumentRoot /Users/$USERNAME/Sites
</VirtualHost>

# Serve ~/Sites/laravel/* at http://*.laravel.localhost
<VirtualHost *:80>
  ServerName laravel.localhost
  ServerAlias *.laravel.localhost
  VirtualDocumentRoot /Users/$USERNAME/Sites/laravel/%1/laravel/public
  DirectoryIndex index.php
</VirtualHost>
EOF

# Set up PEAR
sudo cp /etc/php.ini.default /etc/php.ini
curl -O http://pear.php.net/go-pear.phar
HOME=/usr/local php -d detect_unicode=0 go-pear.phar
echo "/usr/local/pear/bin" | cat - /etc/paths | sudo tee /etc/paths

# Fix the location of MySQL's default socket, which has been wrong since forever
sudo sed -i '' s~pdo_mysql.default_socket=~pdo_mysql.default_socket=/tmp/mysql.sock~g /etc/php.ini
sudo sed -i '' 's~mysql.default_socket =~mysql.default_socket=/tmp/mysql.sock~g' /etc/php.ini
sudo sed -i '' 's~mysqli.default_socket =~mysqli.default_socket=/tmp/mysql.sock~g' /etc/php.ini

# Install ImageMagick
sudo /usr/local/pear/bin/pecl install Imagick-beta --with-imagick=/usr/local

# Set up Node.js
CURRENT_NODE_VERSION="v0.12.2"
wget http://nodejs.org/dist/$CURRENT_NODE_VERSION/node-$CURRENT_NODE_VERSION.pkg
sudo installer -package $CURRENT_NODE_VERSION.pkg -target "/Volumes/Macintosh HD"
rm node-v0.12.0.pkg
sudo chown -R $USERNAME:staff /usr/local
npm install -g bower
npm install -g eslint
npm install -g protractor
npm install -g karma-cli

# Set up RVM
\curl -sSL https://get.rvm.io | bash -s stable
source ~/.bash_profile
rvm install ruby
gem install compass
gem install rails
gem install scss-lint

# Install Python Packages
sh ./pips.sh

# Set up global .gitconfig
echo What is your first name?
read FIRSTNAME
echo What is your last name?
read LASTNAME
echo What is your email?
read EMAIL

git config --global user.name "$FIRSTNAME $LASTNAME"
git config --global user.email $EMAIL
git config --global apply.whitespace fix
git config --global color.ui true
git config --global core.excludesfile /Users/$USERNAME/.gitignore
git config --global core.whitespace trailing-space,space-before-tab

# Make a starter .gitignore
echo '*~
*#
*.sql
.DS_STORE
.svn
.idea
.iml
__MACOSX
.sass-cache
node_modules
sass_extensions
lib/
bower_components
_ide_helper.php
npm-debug.log' > ~/.gitignore

# Set hostname to localhost
sudo scutil --set HostName localhost

# Set up localhost subdomain resolution with dnsmasq
echo conf-dir=/usr/local/etc/dnsmasq.d > /usr/local/etc/dnsmasq.conf
mkdir -p /usr/local/etc/dnsmasq.d
echo address=/localhost/127.0.0.1 > /usr/local/etc/dnsmasq.d/localhost.conf
sudo mkdir -p /etc/resolver
sudo tee /etc/resolver/localhost >/dev/null <<EOF
nameserver 127.0.0.1
EOF
dscacheutil -flushcache
sudo cp -fv /usr/local/opt/dnsmasq/*.plist /Library/LaunchDaemons
sudo chown root /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist
sudo launchctl load /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist

# Set up Sequel Pro
wget https://sequel-pro.googlecode.com/files/sequel-pro-1.0.2.dmg
hdiutil mount sequel-pro-1.0.2.dmg
cp -r /Volumes/Sequel\ Pro\ 1.0.2/Sequel\ Pro.app /Applications/
hdiutil unmount /Volumes/Sequel\ Pro\ 1.0.2
rm sequel-pro-1.0.2.dmg

# Enable PHP modules
sudo tee -a /etc/php.ini >/dev/null <<EOF
extension=imagick.so
extension=pcntl.so
extension=mcrypt.so
EOF

# Make local paths available globally
sudo ln -s /usr/local/bin/aws /usr/bin/aws
sudo ln -s /usr/local/bin/convert /usr/bin/convert
sudo ln -s /usr/local/bin/gs /usr/bin/gs
sudo ln -s /usr/local/bin/pdfinfo /usr/bin/pdfinfo
sudo ln -s /usr/local/bin/pdftk /usr/bin/pdftk

# Make MySQL, Redis, and beanstalkd autostart
mkdir -p ~/Library/LaunchAgents
ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
ln -sfv /usr/local/opt/redis/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.redis.plist
ln -sfv /usr/local/opt/beanstalk/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.beanstalk.plist

# Make Apache autostart
sudo launchctl load -w /System/Library/LaunchDaemons/org.apache.httpd.plist

# Restart Apache in case it was running
sudo apachectl -k restart
