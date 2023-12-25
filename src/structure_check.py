from git import Repo
import os

def check_essential_files_in_git(repo_path):
    essential_files = ['.gitignore', 'LICENSE', 'README.md']
    missing_files = []

    try:
        repo = Repo(repo_path)
    except Exception as e:
        print(f"Error: {e}")
        return

    # Getting the latest commit in the current branch
    latest_commit = next(repo.iter_commits())

    # Check if each essential file is present in the latest commit
    for file in essential_files:
        file_path = os.path.join(repo_path, file)
        if not file_path in (item.a_path for item in latest_commit.diff(None)):
            missing_files.append(file)

    if missing_files:
        print("Missing essential files:", ", ".join(missing_files))
    else:
        print("All essential files are present.")

# Example usage
repo_path = '/path/to/your/repo'  # Replace with the path to your Git repository
check_essential_files_in_git(repo_path)
