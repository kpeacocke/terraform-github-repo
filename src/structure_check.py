# Importing necessary libraries
from git import Repo
import os

# Function to check if essential files are present in the latest commit of a Git repository
def check_essential_files_in_git(repo_path):
    # List of essential files
    essential_files = ['.gitignore', 'LICENSE', 'README.md']
    # List to store the names of missing files
    missing_files = []

    # Try to create a Repo object. If an error occurs (e.g., the repository doesn't exist), print the error and return
    try:
        repo = Repo(repo_path)
    except Exception as e:
        print(f"Error: {e}")
        return

    # Get the latest commit in the current branch
    try:
        latest_commit = next(repo.iter_commits())
    except StopIteration:
        print("Error: No commits found.")
        return

    # For each essential file, check if it's present in the latest commit
    for file in essential_files:
        # Construct the full path to the file
        file_path = os.path.join(repo_path, file)
        # If the file is not in the latest commit, add it to the list of missing files
        if file_path not in (item.a_path for item in latest_commit.diff(None)):
            missing_files.append(file)

    # If there are any missing files, print them
    if missing_files:
        print("Missing essential files:", ", ".join(missing_files))
    # Otherwise, print a message indicating that all essential files are present
    else:
        print("All essential files are present.")

# Example usage
# Replace with the path to your Git repository
repo_path = '/path/to/your/repo'  
# Call the function with the path to your repository
check_essential_files_in_git(repo_path)