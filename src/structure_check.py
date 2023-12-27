# Importing necessary libraries
from git import Repo
import os

# Function to check if essential files are present in the latest commit of a Git repository
def check_essential_files_in_git(repo_path):
    # List of essential files
    essential_files = ['.gitignore', 'LICENSE', 'README.md']
    # List to store the names of missing files
    missing_files = []

    # Try to create a Repo object. If an error occurs (e.g., the repository doesn't exist), return an error message
    try:
        repo = Repo(repo_path)
    except Exception as e:
        return f"Error: {e}"

    # Get the latest commit in the current branch
    try:
        latest_commit = next(repo.iter_commits())
    except StopIteration:
        return "Error: No commits found."

    # For each essential file, check if it's present in the latest commit
    for file in essential_files:
        # Construct the full path to the file
        file_path = os.path.join(repo_path, file)
        # If the file is not in the latest commit, add it to the list of missing files
        if file_path not in (item.a_path for item in latest_commit.diff(None)):
            missing_files.append(file)

    # If there are any missing files, return a message indicating the missing files
    if missing_files:
        return "Missing essential files: " + ", ".join(missing_files)
    # Otherwise, return a message indicating that all essential files are present
    else:
        return "All essential files are present."