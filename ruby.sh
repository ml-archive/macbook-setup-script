#!/bin/bash -f

# Set up RVM
\curl -sSL https://get.rvm.io | bash -s stable
source ~/.bash_profile
rvm install ruby

# Install Ruby Gems
gem install sass --no-document
gem install rails --no-document
gem install scss-lint --no-document
gem install grb --no-document
