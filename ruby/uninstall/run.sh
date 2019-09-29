#!/usr/bin/env bash


DIR=${BASH_SOURCE%/*}

if [ ! ${IS_COLOR_SOURCED} ]; then
    source ${DIR}/../../lib/colors.sh
fi

printf "Y\n" | gem uninstall bundler
printf "Y\n" | gem uninstall grb
printf "Y\n" | gem uninstall cocoapods
printf "Y\n" | gem uninstall xcode-install
printf "Y\n" | gem uninstall slather
printf "Y\n" | gem uninstall xcpretty
printf "Y\n" | gem uninstall fastlane
printf "Y\n" | source ${DIR}/uninstall_rails.sh

if which rbenv > /dev/null; then
    source ${DIR}/uninstall_rbenv.sh
fi

if which rvm > /dev/null; then
    source ${DIR}/uninstall_rvm.sh
fi
