#!/bin/bash

cd /home/app/trunc8r
bundle config set --local without 'development test'
bundle install

rake db:create db:migrate
rails assets:precompile
rm -f tmp/pids/server.pid
rails server -b 0.0.0.0 

