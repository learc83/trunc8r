#!/bin/bash

cd /home/app/trunc8r
bundle config set --local without 'development test'
bundle install

DISABLE_DATABASE_ENVIRONMENT_CHECK=1 rake db:drop db:create db:migrate
rails assets:precompile
rm -f tmp/pids/server.pid
rails server -b 0.0.0.0 

