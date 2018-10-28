#!/usr/bin/env bash


DIR=${BASH_SOURCE%/*}

if [ ! ${IS_COLOR_SOURCED} ]; then
    source ${DIR}/../../lib/colors.sh
fi

source ${DIR}/uninstall_php.sh
source ${DIR}/uninstall_httpd.sh
