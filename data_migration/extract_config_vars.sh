#!/bin/bash

# Check if a file is passed as a command-line argument
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <file_path>"
  exit 1
fi

# Get the input file from the first argument
FILE="$1"

# Check if the file exists
if [ ! -f "$FILE" ]; then
  echo "Error: File '$FILE' does not exist."
  exit 1
fi

# Read the first row (header) and second row (first data row) of the CSV
header=$(head -n 1 "$FILE")
first_row=$(sed -n '2p' "$FILE")

# Extract column positions for dataset_id and facility_id
dataset_id_col=$(echo "$header" | tr ',' '\n' | grep -n '^dataset_id$' | cut -d: -f1)
facility_id_col=$(echo "$header" | tr ',' '\n' | grep -n '^facility_id$' | cut -d: -f1)

# Extract the current values
CURRENT_DATASET_ID=$(echo "$first_row" | cut -d',' -f"$dataset_id_col")
CURRENT_FACILITY_ID=$(echo "$first_row" | cut -d',' -f"$facility_id_col")

# Output the current values to files
echo "$CURRENT_DATASET_ID" > CURRENT_DATASET_ID
echo "$CURRENT_FACILITY_ID" > CURRENT_FACILITY_ID

echo "Extracted CURRENT_DATASET_ID: $CURRENT_DATASET_ID"
echo "Extracted CURRENT_FACILITY_ID: $CURRENT_FACILITY_ID"
