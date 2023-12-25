import unittest
from unittest.mock import patch, MagicMock
from structure_check import check_essential_files_in_git

class TestStructureCheck(unittest.TestCase):

    @patch('structure_check.Repo')
    def test_all_files_present(self, mock_repo):
        # Mock the Repo and iter_commits method
        mock_repo.return_value.iter_commits.return_value = iter([MagicMock()])

        with patch('structure_check.os.path.exists', return_value=True):
            with self.assertLogs() as captured_logs:
                check_essential_files_in_git('/fake/repo')
                self.assertIn("All essential files are present.", captured_logs.output[0])

    @patch('structure_check.Repo')
    def test_missing_files(self, mock_repo):
        # Mock the Repo and iter_commits method
        mock_repo.return_value.iter_commits.return_value = iter([MagicMock()])

        def mock_exists(path):
            return 'README.md' not in path

        with patch('structure_check.os.path.exists', side_effect=mock_exists):
            with self.assertLogs() as captured_logs:
                check_essential_files_in_git('/fake/repo')
                self.assertIn("Missing essential files: README.md", captured_logs.output[0])

    @patch('structure_check.Repo')
    def test_repo_exception(self, mock_repo):
        # Mock the Repo to raise an exception
        mock_repo.side_effect = Exception("Error initializing Repo")

        with self.assertLogs() as captured_logs:
            check_essential_files_in_git('/fake/repo')
            self.assertIn("Error: Error initializing Repo", captured_logs.output[0])

if __name__ == '__main__':
    unittest.main()
