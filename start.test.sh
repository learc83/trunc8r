#!/bin/bash

cd /home/app/trunc8r
# bundle config set --local without 'development'
bundle install

DISABLE_DATABASE_ENVIRONMENT_CHECK=1 rake db:drop db:create db:migrate
rails assets:precompile
printf "%s\n\n\n\n\n\n\n\n\n\n\n\n\n"
echo "Runing rspec tests.................................................."
# echo "Runing model tests.................................................."
rspec -c -fd
# rspec spec/models -fd

# echo "Runing request tests.................................................."
# rspec spec/requests -fd

# echo "Runing feature tests using selenium.................................................."
# rspec spec/features -fd

echo "Rspec tests complete.................................................."

