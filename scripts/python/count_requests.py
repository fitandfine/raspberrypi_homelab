#!/usr/bin/env python3
# --------------------------------------------------------------------------
# count_requests.py — Nginx Request Counter
# Purpose: Calculates the total number of requests served by Nginx today 
#          by reading the access log file. It uses the simplest, fastest 
#          method: counting lines, since each line represents one request.
# Dependencies: None (Uses standard Python library).
# Usage:   ./make.sh request_counter.py
# --------------------------------------------------------------------------

import os
import sys

# Define where Nginx stores its access log. 
# I assume the default path for standard Linux setups.
# LOG_FILE = "/var/log/apache2/access.log" This can be used to count apache requests.

LOG_FILE = "/var/log/nginx/access.log"

# Initialize the counter variable.
count = 0

try:
    # --- File Check ---
    # Check if the file exists before trying to open it.
    if not os.path.exists(LOG_FILE):
        print(f"Error: Log file not found at {LOG_FILE}.")
        # Exit with a non-zero code to indicate failure.
        sys.exit(1)

    # --- File Reading and Counting ---
    # Using 'with open' ensures the file is automatically closed, even if errors occur.
    # I open it in read mode ("r").
    with open(LOG_FILE, "r") as file:
        
        # This is the core logic: iterate over every line in the file.
        for line in file:
            # Since Nginx logs one HTTP request per line, we just increment the counter.
            count += 1

    # --- Output ---
    print("--------------------------------------------------")
    print("📈 Nginx Request Tally (Today's Access Log)")
    print("--------------------------------------------------")
    print(f"Total number of requests processed: {count}")
    print("--------------------------------------------------")

except PermissionError:
    # We catch this specific error because log files often require root privileges.
    print(f"Error: Permission denied when trying to read {LOG_FILE}.")
    print("Try running the script again using 'sudo ./make.sh count_requests.py'")
    sys.exit(1)
except Exception as e:
    # This catches any other unexpected errors during execution.
    print(f"An unexpected error occurred while reading the log: {e}")
    sys.exit(1)