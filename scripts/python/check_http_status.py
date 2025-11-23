#!/usr/bin/env python3
# Make sure there is python3 in the shebang line to avoid confusion.
# This task can also be performed using curl in bash, but I wanted to practice Python scripting.
# -----------------------------------------------------------
# check_http_status.py — Simple HTTP Status Checker for NGINX

# I wrote this script because I wanted to check if my nginx homepage is responding.
# Using 'requests' library because it's way easier than urllib (which is too messy).
# Make sure you have requests installed: pip install requests
# This script simply fetches the homepage and prints the status code and part of the content.


import requests

# This is the URL my nginx serves by default.
URL = "http://localhost"

try:
    # Sending a GET request. Pretty straightforward.
    response = requests.get(URL)

    # .status_code gives HTTP code like 200, 404, 500 etc.
    print("Status code from server:", response.status_code)
    # Just printing first 100 chars so I know it's not empty.
    print("First part of the page:", response.text[:100])

    # Redundant, but I wanted to make the output more obvious and human redable.
    if response.status_code == 200:
        print("------------NGINX is up and running!------------")
    else:
        print("----------NGINX might be down or not serving correctly.------------")



except Exception as e:
    # If nginx is down or URL is wrong, it ends up here.
    print("Something went wrong:", e)
