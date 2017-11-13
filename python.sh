#!/bin/bash -f

# Set up pip and AWS CLI
sudo easy_install pip

# Install Python Packages
sudo pip install awscli --upgrade --user
sudo pip install awsebcli --upgrade --user
sudo pip install virtualenv