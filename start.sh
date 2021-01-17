#!/bin/bash

cd /home/app/trunc8r
rm -f tmp/pids/server.pid
/bin/webpacker-dev
echo "doin stuff....................."
RAILS_ENV=production rails assets:precompile
RAILS_SERVE_STATIC_FILES=true rails server -b 0.0.0.0 -e production
