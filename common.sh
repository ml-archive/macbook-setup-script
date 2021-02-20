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
printf '%s ' 'What is your first name?'
read FIRSTNAME
printf '%s ' 'What is your last name?'
read LASTNAME
printf '%s ' 'What is your email?'
read EMAIL

git config --global user.name "$FIRSTNAME $LASTNAME"
git config --global user.email $EMAIL
git config --global apply.whitespace fix
git config --global color.ui true
git config --global core.excludesfile /Users/$USER/.gitignore
git config --global core.whitespace trailing-space,space-before-tab

mkdir $HOME/bin
curl -o $HOME/bin/git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
curl -o $HOME/bin/git-completion.zsh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew doctor

# Update brew just in case...
brew update

# Packages needed to build new swift versions from source
brew install cmake
brew install ninja

# Set up some Homebrew packages
brew install wget
brew install ImageMagick
brew install redis
brew install pkg-config
brew install pcre
brew install dnsmasq
brew install cloc
brew install xctool
brew install libimobiledevice
brew install openssl
brew install awscli

# Make Redis autostart
brew services start redis

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
