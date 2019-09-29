#!/usr/bin/env bash

gem uninstall rails

if [ -d ${HOME}/Sites/rails-playground ]; then
  mv ${HOME}/Sites/rails-playground ${HOME}/Sites/rails-playground-backup
fi
