#!/usr/bin/env python3
"""Test the full fix_mike_info.py script"""
import os
import sys
import json
import shutil
from pathlib import Path
import tempfile

# Create a test environment
test_dir = Path(tempfile.mkdtemp())
mike_dir = test_dir / ".mike"
mike_dir.mkdir()
versions_dir = mike_dir / "versions"
versions_dir.mkdir()

# Create test version directories
(versions_dir / "latest").mkdir()
(versions_dir / "1.0.0").mkdir()
try:
    # This might fail on some systems
    (versions_dir / "Latest (main)").mkdir()
except:
    pass

# Create test info.json
test_info = {
    "aliases": {"latest": "1.0.0", "stable": "1.0.0"},
    "versions": ["1.0.0", "latest", "Latest (main)"],
    "version_title_map": {"latest": "Latest Version", "1.0.0": "Version 1.0.0"}
}
with open(mike_dir / "info.json", "w") as f:
    json.dump(test_info, f, indent=2)

# Print the test environment
print(f"Created test environment at {test_dir}")
print(f"Directories: {list(os.listdir(versions_dir))}")
print(f"info.json: {json.dumps(test_info, indent=2)}")

# Import and patch the script
sys.path.append(str(Path(__file__).parent))
import fix_mike_info
original_mike_info = fix_mike_info.MIKE_INFO_FILE
original_mike_versions = fix_mike_info.MIKE_VERSIONS_DIR

# Override constants for testing
fix_mike_info.MIKE_INFO_FILE = str(mike_dir / "info.json")
fix_mike_info.MIKE_VERSIONS_DIR = str(versions_dir)

print("\n=== Running full script ===")
try:
    result = fix_mike_info.main()
    print(f"Script result: {result}")
    
    # Show results
    print("\nAfter cleaning:")
    print(f"Directories: {list(os.listdir(versions_dir))}")
    with open(mike_dir / "info.json", "r") as f:
        cleaned_info = json.load(f)
        print(f"info.json: {json.dumps(cleaned_info, indent=2)}")
    
    # Check if it worked correctly
    expected_dirs = ["1.0.0"]  # Only non-latest directories should remain
    actual_dirs = list(os.listdir(versions_dir))
    if set(actual_dirs) != set(expected_dirs):
        print("❌ Directory test failed")
    else:
        print("✅ Directory test passed")
    
    # Check info.json
    if "latest" in cleaned_info["aliases"] or "latest" in cleaned_info["versions"]:
        print("❌ info.json test failed - 'latest' still exists")
    else:
        print("✅ info.json test passed")
    
finally:
    # Restore constants
    fix_mike_info.MIKE_INFO_FILE = original_mike_info
    fix_mike_info.MIKE_VERSIONS_DIR = original_mike_versions
    
    # Clean up
    shutil.rmtree(test_dir)

print("\nTest completed")
