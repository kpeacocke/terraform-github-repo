import unittest
from unittest.mock import Mock, patch
from src.structure_check import check_essential_files_in_git

class TestStructureCheck(unittest.TestCase):

    @patch('src.structure_check.Repo', autospec=True)
    def test_all_essential_files_present(self, mock_repo):
        # Mock the necessary objects and methods
        repo = mock_repo.return_value
        mock_commit = Mock()
        
        # Mock diff items for each essential file
        essential_files = [".gitignore", "LICENSE", "README.md"]
        mock_diff_items = [Mock(a_path=file) for file in essential_files]
        
        mock_commit.diff.return_value = mock_diff_items
        repo.iter_commits.return_value = iter([mock_commit])  # Return an iterable

        result = check_essential_files_in_git('/path/to/your/repo')
        self.assertEqual(result, "All essential files are present.")

    @patch('src.structure_check.Repo', autospec=True)
    def test_missing_essential_file(self, mock_repo):
        # Mock the necessary objects and methods
        repo = mock_repo.return_value
        mock_commit = Mock()
        mock_diff_item = Mock()
        mock_diff_item.a_path = "README.md"
        mock_commit.diff.return_value = [mock_diff_item]
        repo.iter_commits.return_value = iter([mock_commit])  # Return an iterable

        result = check_essential_files_in_git('/path/to/your/repo')
        self.assertEqual(result, "Missing essential files: .gitignore, LICENSE")

    @patch('src.structure_check.Repo', autospec=True)
    def test_no_commits_found(self, mock_repo):
        # Mock the necessary objects and methods
        repo = mock_repo.return_value
        repo.iter_commits.return_value = iter([])  # Return an empty iterable

        result = check_essential_files_in_git('/path/to/your/repo')
        self.assertEqual(result, "Error: No commits found.")

    @patch('src.structure_check.Repo', autospec=True)
    def test_nonexistent_repository(self, mock_repo):
        # Mock the necessary objects and methods to raise an exception
        mock_repo.side_effect = Exception("Repository not found")

        result = check_essential_files_in_git('/path/to/nonexistent/repo')
        self.assertTrue(result.startswith("Error:"))

if __name__ == '__main__':
    unittest.main()
