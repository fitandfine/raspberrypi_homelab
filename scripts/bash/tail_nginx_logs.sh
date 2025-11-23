#!/usr/bin/env bash
# --------------------------------------------------------------------------
# Script: tail_nginx.logs.sh
# Purpose: Tails and displays both the Nginx access.log and error.log 
#          simultaneously in a single terminal session.
# Dependencies: None.
# Usage:   ./make.sh tail_nginx.logs.sh
# --------------------------------------------------------------------------

# Can be adapted for Apache logs by changing the log file paths.
#ACCESS_LOG="/var/log/apache2/access.log"
#ERROR_LOG="/var/log/apache2/error.log"

# Log file paths
ACCESS_LOG="/var/log/nginx/access.log"
ERROR_LOG="/var/log/nginx/error.log"

# --- Pre-Execution Checks ---

# 1. Check if files exist
if [ ! -f "$ACCESS_LOG" ] || [ ! -f "$ERROR_LOG" ]; then
    echo "Error: One or both Nginx log files are missing."
    echo "Expected locations: $ACCESS_LOG and $ERROR_LOG"
    exit 1
fi

# 2. Check for read permissions (Crucial since logs require root access)
if [ ! -r "$ACCESS_LOG" ] || [ ! -r "$ERROR_LOG" ]; then
    echo "Warning: No read permissions for log files."
    echo "You must run this script with 'sudo' to access the logs."
    echo "Try: sudo ./make.sh tail_nginx.logs.sh"
    exit 1
fi

# --- Execution ---

echo "Tailing both access and error logs..."
echo "Press CTRL+C to stop monitoring."
echo "-----------------------------------------------------------"

# 'tail -f' handles multiple files by displaying which file the output came from.
# The '|' pipe operator is removed as it serves no purpose here.
sudo tail -f "$ACCESS_LOG" "$ERROR_LOG"