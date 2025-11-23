#!/usr/bin/env bash

# This is the same make.sh script as in bash, but placed here in python folder
# to allow execution of python scripts as well.
 # the header of python scripts should still be #!/usr/bin/env python3 to tell the system to use python3 interpreter.
 
# -----------------------------------------------------------
# make.sh — Utility Script Executor
# Author: Anup Chapain
#
# This script takes any Bash script as an argument, marks it
# as executable, and then runs it. It is designed to simplify
# the workflow for running automation scripts in this project.
#
# Usage:
#   ./make.sh scriptname.sh
# -----------------------------------------------------------


# Ensure exactly one input argument is provided
if [[ $# -ne 1 ]]; then
  echo "Usage: ./make.sh <script-file.sh / .py>"
  echo "Example: ./make.sh monitor_nginx.sh"
  exit 1
fi

# Check if the file exists
if [[ ! -f $1 ]]; then
  echo "Error: File '$1' not found!"
  exit 1
fi

echo "✔ Making file '$1' executable..."
chmod +x "$1"

echo "✔ Running '$1'..."
./"$1"

echo "✔ Finished executing '$1'"
echo "-----------------------------------------------------------"
