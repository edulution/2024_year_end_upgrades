import pandas as pd
import sys


def add_time_spent(file_path):
    # Load the CSV file into a DataFrame
    df = pd.read_csv(file_path)

    # Add the new column with a default value of 0
    df["time_spent"] = 0

    # Save the modified DataFrame back to the same file
    df.to_csv(file_path, index=False)


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python add_time_spent.py <file_path>")
        sys.exit(1)

    file_path = sys.argv[1]
    try:
        add_time_spent(file_path)
        print("File modified successfully.")
    except Exception as e:
        print(f"An error occurred: {e}")
