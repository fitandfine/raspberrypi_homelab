#!/usr/bin/env bash

# Backup script because I broke nginx.conf too many times.
# /etc/nginx/ is where all the important files live.
# Backups will be stored in ~/nginx_backups/ with timestamped folders.
# Usage: Just run this script whenever you want to take a backup.
# Make sure you have enough space in your home directory.
# You can automate this with cron if you want regular backups.
# Example cron entry for daily backup at 2am:
# 0 2 * * * /path/to/backup_nginx_config.sh
# Adjust the path accordingly.
# Or run it manually before making changes to nginx config.
# You can restore by copying files back from the backup folder to /etc/nginx/
# Remember to restart nginx after restoring.
# sudo systemctl restart nginx
# This script can be modified to accept backup location as an argument if needed.
# $1 would be the first argument in that case.
# For now, it's hardcoded to ~/nginx_backups/
# Enjoy peace of mind!

SOURCE_DIR="/etc/nginx"
BACKUP_DIR="$HOME/nginx_backups"

echo "Backing up nginx config..."

# This 'mkdir -p' means "make directory if it doesn't exist".
mkdir -p "$BACKUP_DIR"

# Using date so each backup folder has a timestamp.
timestamp=$(date +"%Y-%m-%d-%H-%M-%S")

# Copying entire nginx folder instead of individual files
# because I always forget which files are important.
cp -r "$SOURCE_DIR" "$BACKUP_DIR/nginx-backup-$timestamp"

echo "Backup created at: $BACKUP_DIR/nginx-backup-$timestamp"
echo "✔ Backup completed successfully."