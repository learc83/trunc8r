#!/bin/bash

cd /home/app/trunc8r
# bundle config set --local without 'development'
bundle install

DISABLE_DATABASE_ENVIRONMENT_CHECK=1 rake db:drop db:create db:migrate
rails assets:precompile
printf "%s\n\n\n\n\n\n\n\n\n\n\n\n\n"
echo "Running rspec tests.................................................."
rspec -c -fd
echo "Rspec tests complete.................................................."

