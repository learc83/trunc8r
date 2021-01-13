#!/bin/bash

cd /home/app/trunc8r
rm -f tmp/pids/server.pid
rails server -b 0.0.0.0
