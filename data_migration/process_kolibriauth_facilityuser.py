import pandas as pd
import sys


def modify_csv(file_path):
    # Load the CSV file into a DataFrame
    df = pd.read_csv(file_path)

    # Drop specified columns
    columns_to_drop = ["deleted", "birth_year", "exam_number", "gender"]
    df = df.drop(columns=columns_to_drop, errors="ignore")

    # Add new columns with specified values
    df["birth_year"] = 2013
    df["gender"] = 2013
    df["id_number"] = 1234
    df["deleted"] = False

    # Save the modified DataFrame back to the same file
    df.to_csv(file_path, index=False)


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python modify_csv.py <file_path>")
        sys.exit(1)

    file_path = sys.argv[1]
    try:
        modify_csv(file_path)
        print("File modified successfully.")
    except Exception as e:
        print(f"An error occurred: {e}")
