#!/bin/bash

cd /home/app/test2
bundle install
rm -f tmp/pids/server.pid
rails server -b 0.0.0.0
