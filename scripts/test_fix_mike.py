#!/usr/bin/env python3
"""Test the fix_mike_info.py script"""

from fix_mike_info import (
    is_latest_name,
    clean_aliases,
    clean_versions,
    fix_version_title_map
)
import os
import sys
import json
import shutil
from pathlib import Path

sys.path.append(str(Path(__file__).parent))

# Create a test directory
TEST_DIR = Path(".mike_test")
if TEST_DIR.exists():
    shutil.rmtree(TEST_DIR)
TEST_DIR.mkdir(exist_ok=True)
(TEST_DIR / "versions").mkdir(exist_ok=True)
(TEST_DIR / "versions" / "latest").mkdir(exist_ok=True)
(TEST_DIR / "versions" / "1.0.0").mkdir(exist_ok=True)

# Create a test info.json
test_info: dict[str, dict[str, str] | list[str] | dict[str, str]] = {
    "aliases": {"latest": "1.0.0", "stable": "1.0.0"},
    "versions": ["1.0.0", "latest", "Latest (main)"],
    "version_title_map": {"latest": "Latest Version", "1.0.0": "Version 1.0.0"}
}
with open(TEST_DIR / "info.json", "w") as f:
    json.dump(test_info, f, indent=2)

# Print the test environment
print("Created test environment:")
print(f"Directories: {list(os.listdir(TEST_DIR / 'versions'))}")
print(f"info.json: {json.dumps(test_info, indent=2)}")

# Test functions individually
print("\n=== Testing is_latest_name ===")
test_names = [
    "latest",
    "Latest",
    "LATEST",
    "Latest (main)",
    '"Latest (main)"',
    "1.0.0"
]
for name in test_names:
    print(f"{name}: {is_latest_name(name)}")

print("\n=== Testing clean_aliases ===")
aliases_copy = json.loads(json.dumps(test_info))
changes = clean_aliases(aliases_copy)
print(f"Changes made: {changes}")
print(f"After: {json.dumps(aliases_copy, indent=2)}")

print("\n=== Testing clean_versions ===")
versions_copy = json.loads(json.dumps(test_info))
changes = clean_versions(versions_copy)
print(f"Changes made: {changes}")
print(f"After: {json.dumps(versions_copy, indent=2)}")

print("\n=== Testing fix_version_title_map ===")
title_map_copy = json.loads(json.dumps(test_info))
changes = fix_version_title_map(title_map_copy)
print(f"Changes made: {changes}")
print(f"After: {json.dumps(title_map_copy, indent=2)}")

# Clean up
shutil.rmtree(TEST_DIR)

print("\nAll tests completed successfully")
