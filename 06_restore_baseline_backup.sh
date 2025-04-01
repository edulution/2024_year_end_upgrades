#!/bin/bash

# Check if a date argument was provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 YYYYMMDD"
    exit 1
fi

# Capture the target date
TARGET_DATE=$1

# Validate the date format (YYYYMMDD)
if [[ ! $TARGET_DATE =~ ^[0-9]{8}$ ]]; then
    echo "Error: Date must be in the format YYYYMMDD."
    exit 1
fi


BACKUPS_DIR=~/backups 

# Find the first backup file matching the date
BACKUP_FILE=$(ls $BACKUPS_DIR | grep -E "^[A-Z]{3}_backups_${TARGET_DATE}\.zip$" | sort | head -n 1)

if [ -z "$BACKUP_FILE" ]; then
    echo "No backup file found for the date $TARGET_DATE."
    exit 0
fi

echo "Found backup file: $BACKUP_FILE"

# Unzip the file to the current directory
unzip "$BACKUPS_DIR/$BACKUP_FILE"

# Check if the unzip command was successful
if [ $? -eq 0 ]; then
    echo "Backup file successfully unzipped."
else
    echo "Error unzipping the file."
    exit 1
fi

# Assuming TARGET_DATE is already defined and backup file has been unzipped

# Search for the baseline file matching the date
BASELINE_FILE=$(find . -type f -name "???_baseline_${TARGET_DATE}.backup" | head -n 1)


if [ -z "$BASELINE_FILE" ]; then
    echo "No baseline file found for the date $TARGET_DATE."
    exit 0
fi

echo "Found baseline file: $BASELINE_FILE"

sudo -i -u postgres psql << EOF
    drop database if exists baseline_testing;
    create database baseline_testing;
    grant all on database baseline_testing to baseline_testing;
EOF

# Restore the baseline backup into the baseline db. get credentials from env variables
echo "Restoring backup file: $BASELINE_FILE into Database: $BASELINE_DATABASE_NAME"
PGPASSWORD=$BASELINE_DATABASE_PASSWORD pg_restore -U "$BASELINE_DATABASE_USER" -h "$BASELINE_DATABASE_HOST" -p "$BASELINE_DATABASE_PORT" -d "$BASELINE_DATABASE_NAME" --no-owner --verbose "$BASELINE_FILE"
