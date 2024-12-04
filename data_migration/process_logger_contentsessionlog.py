import pandas as pd
import sys


def add_visitor_id(file_path):
    # Load the CSV file into a DataFrame
    df = pd.read_csv(file_path)

    # Check if the 'user_id' column exists
    if "user_id" in df.columns:
        # Add the new column and copy values from 'user_id'
        df["visitor_id"] = df["user_id"]
    else:
        print("Error: 'user_id' column does not exist in the file.")
        sys.exit(1)

    # Save the modified DataFrame back to the same file
    df.to_csv(file_path, index=False)


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python add_visitor_id.py <file_path>")
        sys.exit(1)

    file_path = sys.argv[1]
    try:
        add_visitor_id(file_path)
        print("File modified successfully.")
    except Exception as e:
        print(f"An error occurred: {e}")
