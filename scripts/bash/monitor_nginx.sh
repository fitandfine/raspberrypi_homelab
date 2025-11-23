#!/usr/bin/env bash

# if you have apache2 installed and running, this script may not work as expected
# because both nginx and apache2 try to use the same port (80) by default.

# considering there is no conflict with apache2, this script checks if nginx is running
# and starts it if it's not running.

# I always start by printing something so I know the script actually ran.
echo "Starting simple NGINX monitor..."

# 'systemctl is-active' returns 'active' if running, so checking that here.
status=$(systemctl is-active nginx)

# Just printing the result so I don't have to type this command manually again.
echo "NGINX status is: $status"

# This checks if nginx is NOT active. The exclamation mark basically flips the check ( NOT gate).
if [[ "$status" != "active" ]]; then
    echo "Looks like nginx is down... trying to start it."

    # Using sudo because nginx is a system-level service.
    sudo systemctl start nginx

    # Checking again after trying to start it.
    new_status=$(systemctl is-active nginx)
    echo "After restart attempt, status is: $new_status"
else
    echo "Great! nginx is running fine."
fi
