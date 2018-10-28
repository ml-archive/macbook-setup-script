#!/bin/bash -f

# Install Xcode command line tools
xcode-select --install

# Make some default folders
mkdir -p $HOME/Sites

# Make a starter .gitignore
echo '*~
*#
.DS_STORE
.svn
.idea
.iml
__MACOSX
.sass-cache
npm-debug.log' > ~/.gitignore

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
git config --global core.excludesfile /Users/$USER/.gitignore
git config --global core.whitespace trailing-space,space-before-tab

# Install Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor

# Update brew just in case...
brew update

brew cask install xquartz

# Packages needed to build new swift versions from source
brew install cmake
brew install ninja
sudo gem install cocoapods

# Set up some Homebrew packages
brew install wget
brew install ImageMagick
brew install ghostscript
brew install autoconf
brew install mysql
brew install redis
brew install beanstalkd
brew install poppler
brew install pkg-config
brew install pcre
brew install dnsmasq

# Make MySQL, Redis, and beanstalkd autostart
brew services start mysql
brew services start redis
brew services start beanstalkd

# Set up localhost subdomain resolution with dnsmasq
echo conf-dir=/usr/local/etc/dnsmasq.d > /usr/local/etc/dnsmasq.conf
mkdir -p /usr/local/etc/dnsmasq.d
echo address=/localhost/127.0.0.1 > /usr/local/etc/dnsmasq.d/localhost.conf
sudo mkdir -p /etc/resolver
sudo tee /etc/resolver/localhost >/dev/null <<EOF
nameserver 127.0.0.1
EOF
dscacheutil -flushcache

brew services restart dnsmasq

