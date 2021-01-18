#!/bin/bash

cd /home/app/trunc8r
rm -f tmp/pids/server.pid
bin/webpack-dev-server &
rails server -b 0.0.0.0 
