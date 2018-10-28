#!/usr/bin/env bash


DIR=${BASH_SOURCE%/*}

if [ ! ${IS_COLOR_SOURCED} ]; then
    source ${DIR}/../../lib/colors.sh
fi

/usr/bin/yes | pip3 uninstall awscli
/usr/bin/yes | pip3 uninstall awsebcli
/usr/bin/yes | pip3 uninstall virtualenv
brew uninstall python
brew uninstall python@2
