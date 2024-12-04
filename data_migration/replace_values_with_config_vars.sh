#!/bin/bash

# Function to display usage instructions
usage() {
  echo "Usage: $0 [-d] [-f] <file_path>"
  echo "Options:"
  echo "  -d    Replace dataset_id"
  echo "  -f    Replace facility_id"
  exit 1
}

# Check if at least one argument is passed
if [ "$#" -lt 2 ]; then
  usage
fi

# Parse command-line options
REPLACE_DATASET_ID=false
REPLACE_FACILITY_ID=false

while getopts "df" opt; do
  case $opt in
    d) REPLACE_DATASET_ID=true ;;
    f) REPLACE_FACILITY_ID=true ;;
    *) usage ;;
  esac
done

# Shift positional arguments to get the file path
shift $((OPTIND - 1))
FILE="$1"

# Validate the file path
if [ -z "$FILE" ]; then
  echo "Error: File path is required."
  usage
fi

if [ ! -f "$FILE" ]; then
  echo "Error: File '$FILE' does not exist."
  exit 1
fi

# Read the values from the files
if $REPLACE_DATASET_ID; then
  if [ ! -f "CURRENT_DATASET_ID" ]; then
    echo "Error: CURRENT_DATASET_ID file not found."
    exit 1
  fi
  CURRENT_DATASET_ID=$(cat CURRENT_DATASET_ID)
fi

if $REPLACE_FACILITY_ID; then
  if [ ! -f "CURRENT_FACILITY_ID" ]; then
    echo "Error: CURRENT_FACILITY_ID file not found."
    exit 1
  fi
  CURRENT_FACILITY_ID=$(cat CURRENT_FACILITY_ID)
fi

# Define the output file
NEW_FILE="processed_$(basename "$FILE")"

# Query new values if needed
if $REPLACE_DATASET_ID; then
  NEW_DATASET_ID=$(PGPASSWORD=$KOLIBRI_DATABASE_PASSWORD psql -h "$KOLIBRI_DATABASE_HOST" \
    -U "$KOLIBRI_DATABASE_USER" -d "$KOLIBRI_DATABASE_NAME" \
    -t -c "SELECT dataset_id FROM kolibriauth_collection WHERE kind = 'facility' LIMIT 1;" | xargs)
  echo "New Dataset ID: $NEW_DATASET_ID"
fi

if $REPLACE_FACILITY_ID; then
  NEW_FACILITY_ID=$(PGPASSWORD=$KOLIBRI_DATABASE_PASSWORD psql -h "$KOLIBRI_DATABASE_HOST" \
    -U "$KOLIBRI_DATABASE_USER" -d "$KOLIBRI_DATABASE_NAME" \
    -t -c "SELECT id FROM kolibriauth_collection WHERE kind = 'facility' LIMIT 1;" | xargs)
  echo "New Facility ID: $NEW_FACILITY_ID"
fi

# Perform replacements
sed_script=""
if $REPLACE_DATASET_ID; then
  sed_script+="s/$CURRENT_DATASET_ID/$NEW_DATASET_ID/g;"
fi

if $REPLACE_FACILITY_ID; then
  sed_script+="s/$CURRENT_FACILITY_ID/$NEW_FACILITY_ID/g;"
fi

# Apply sed script if replacements are requested
if [ -n "$sed_script" ]; then
  sed "$sed_script" "$FILE" > "$NEW_FILE"
  echo "Modified file created: $NEW_FILE"
else
  echo "No replacements specified. Original file unchanged."
fi
