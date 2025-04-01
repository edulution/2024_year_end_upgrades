#!/bin/bash

# Check if a date argument was provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 YYYYMMDD"
    exit 1
fi

# Capture the target date
TARGET_DATE=$1

BACKUPS_DIR=~/backups

# Validate the date format (YYYYMMDD)
if [[ ! $TARGET_DATE =~ ^[0-9]{8}$ ]]; then
    echo "Error: Date must be in the format YYYYMMDD."
    exit 1
fi

# Find the first backup file matching the date
BACKUP_FILE=$(ls $BACKUPS_DIR | grep -E "^[A-Z]{3}_backups_${TARGET_DATE}\.zip$" | sort | head -n 1)

if [ -z "$BACKUP_FILE" ]; then
    echo "No backup file found for the date $TARGET_DATE."
    exit 0
fi

echo "Found backup file: $BACKUP_FILE"

# Unzip the file to the current directory
unzip "$BACKUP_FILE"

# Check if the unzip command was successful
if [ $? -eq 0 ]; then
    echo "Backup file successfully unzipped."
else
    echo "Error unzipping the file."
    exit 1
fi
