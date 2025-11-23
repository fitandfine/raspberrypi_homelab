#!/usr/bin/env bash

# I wrote this because I was getting tired of restarting nginx every time
# I edited index.html. Using inotifywait (from inotify-tools) to watch changes.
# This has the best use case when runs as a service.
# This will occupy yout terminal untill you stop it with Ctrl+C.
# Make sure inotify-tools is installed: sudo apt install inotify-tools
# This directory is where nginx stores the default site files.
WATCH_DIR="/var/www/html"

echo "Watching $WATCH_DIR for changes..."

# I always forget this: '-m' means monitor continuously, not exit after first event.
# 'modify,create,delete' are the events I care about.
inotifywait -m -e modify,create,delete "$WATCH_DIR" | while read line; do
    echo "Detected a change: $line"
    
    # Before restarting nginx, I run nginx -t because if the config is broken,
    # restarting blindly will break everything.
    echo "Checking nginx configuration..."
    sudo nginx -t

    if [[ $? -eq 0 ]]; then
        echo "Config test passed. Restarting nginx..."
        sudo systemctl restart nginx
    else
        echo "Config test FAILED. Not restarting. Fix the config!"
    fi
done
