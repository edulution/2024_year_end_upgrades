import pandas as pd
import sys


def modify_columns(file_path):
    # Load the CSV file into a DataFrame
    df = pd.read_csv(file_path)

    # Set existing columns to default values
    if "channels" in df.columns:
        df["channels"] = 0
    if "pages" in df.columns:
        df["pages"] = 0

    # Add the new column with the specified value
    df["device_info"] = "Linux,x86_64/Chrome,131"

    # Save the modified DataFrame back to the same file
    df.to_csv(file_path, index=False)


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python modify_channels_pages_device_info.py <file_path>")
        sys.exit(1)

    file_path = sys.argv[1]
    try:
        modify_columns(file_path)
        print("File modified successfully.")
    except Exception as e:
        print(f"An error occurred: {e}")
