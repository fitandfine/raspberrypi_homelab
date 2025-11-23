#!/usr/bin/env bash

# I wrote this because I was getting tired of restarting nginx every time
# I edited index.html. Using inotifywait (from inotify-tools) to watch changes.
# Make sure inotify-tools is installed: sudo apt install inotify-tools
# This has the best use case when runs as a service.
# This will occupy yout terminal untill you stop it with Ctrl+C.
# Without adding it to .service, you can run it in the background using nohup ( No Hang Up)
# sudo nohup ./restart_on_change.sh > /dev/null 2>&1 &
# > /dev/null 2>&1 directs output to the "void" so it doesn't fill up your disk with "Watching..." logs ( recommended if running long term)
# Verify it's running: Use ps to find the process.
# ps aux | grep restart_on_change.sh
# sudo kill 12345  # Replace 12345 with the actual PID found from the previous command.
# or you can type: $ jobs to see background jobs in current terminal session.
# then use: $ kill %1  # Replace 1 with the job number if multiple jobs are running.



# For the sake of simplicity, I'm avoiding the instruction to add this script to services. 


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
