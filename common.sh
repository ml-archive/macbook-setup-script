#!/bin/bash -f

# Install Xcode command line tools
xcode-select --install

# Set hostname to localhost
sudo scutil --set HostName localhost

# Make some default folders
mkdir -p $HOME/Sites/laravel

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
git config --global core.excludesfile /Users/$USERNAME/.gitignore
git config --global core.whitespace trailing-space,space-before-tab

# Install Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor

# Update brew just in case...
brew update

# Get wget first, we will use it later for many things.
brew install wget

# Set up XQuartz
wget https://dl.bintray.com/xquartz/downloads/XQuartz-2.7.11.dmg
hdiutil mount XQuartz-2.7.11.dmg
sudo installer -package /Volumes/XQuartz-2.7.11/XQuartz.pkg -target "/"
hdiutil unmount /Volumes/XQuartz-2.7.11
rm XQuartz-2.7.11.dmg

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

# Make MySQL, Redis, and beanstalkd autostart
mkdir -p ~/Library/LaunchAgents
ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
ln -sfv /usr/local/opt/redis/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.redis.plist
ln -sfv /usr/local/opt/beanstalk/*.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.beanstalk.plist


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

# Give /usr/local normal permissions
sudo chown -R $USERNAME:staff /usr/local

# Set up Sequel Pro
SEQUEL_PRO_INSTALL_VERSION=$(wget -qO- https://github.com/sequelpro/sequelpro/releases/latest | sed -nE 's|.*>release-(.*)</a>|\1|p')
wget "https://github.com/sequelpro/sequelpro/releases/download/release-${SEQUEL_PRO_INSTALL_VERSION}/sequel-pro-${SEQUEL_PRO_INSTALL_VERSION}.dmg" -O $HOME/Downloads/sequel-pro-${SEQUEL_PRO_INSTALL_VERSION}.dmg
hdiutil mount sequel-pro-${SEQUEL_PRO_INSTALL_VERSION}.dmg
cp -r /Volumes/Sequel\ Pro\ ${SEQUEL_PRO_INSTALL_VERSION}/Sequel\ Pro.app /Applications/
hdiutil unmount /Volumes/Sequel\ Pro\ ${SEQUEL_PRO_INSTALL_VERSION}
open /Applications/Sequel\ Pro.app
rm sequel-pro-${SEQUEL_PRO_INSTALL_VERSION}.dmg

# Set up Slack
wget "https://slack.com/ssb/download-osx" -O $HOME/Downloads/Slack-macOS.zip
unzip $HOME/Downloads/Slack-macOS.zip
mv $HOME/Downloads/Slack.app /Applications/Slack.app
open /Applications/Slack.app
rm $HOME/Downloads/Slack-macOS.zip