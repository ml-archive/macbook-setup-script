#!/usr/bin/env bash

gem install rails

if which rbenv > /dev/null; then
    rbenv rehash
fi

rails -v
rails new ${HOME}/Sites/rails-playground --api
(cd ${HOME}/Sites/rails-playground; rails server -d)
open http://localhost:3000
sleep 1
kill $(cat ${HOME}/Sites/rails-playground/tmp/pids/server.pid)
