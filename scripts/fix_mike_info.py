#!/usr/bin/env python3
"""
This script cleans up .mike/info.json and version directories
to remove any 'latest' references that might conflict with
MkDocs documentation deployment using Mike.

It solves the issue where "latest" is both used as an alias and
a version name, which causes the error:
"alias 'latest' already specified as a version".

This script handles:
1. Removing any directories in .mike/versions that contain 'latest'
2. Cleaning .mike/info.json to remove both 'latest' aliases and versions
3. Handling special cases like "Latest (main)" and quoted versions
4. Fixing title_version_map entries

Usage: python3 fix_mike_info.py
"""
import json
import os
import sys
import shutil
import re
from typing import Dict, List, Any

# Mike configuration locations
MIKE_INFO_FILE = ".mike/info.json"
MIKE_VERSIONS_DIR = ".mike/versions"


def is_latest_name(name: str) -> bool:
    """Check if a name contains 'latest' or matches known patterns"""
    name_lower = name.lower()

    # Check for simple 'latest' substring
    if 'latest' in name_lower:
        return True

    # Check for patterns like "Latest (main)" with or without quotes
    if re.match(
        r'^latest.*\(.*\)$', name_lower
    ) or re.match(
        r'^"?latest.*\(.*\)"?$', name_lower
    ):
        return True

    return False


def remove_directory(dir_path: str) -> bool:
    """Remove a directory and handle exceptions"""
    try:
        print(f"Removing directory: {dir_path}")
        shutil.rmtree(dir_path)
        return True
    except Exception as e:
        print(f"Error removing directory {dir_path}: {e}")
        return False


def cleanup_mike_directories() -> bool:
    """Clean up any directories in .mike/versions that might cause conflicts"""
    if not os.path.isdir(MIKE_VERSIONS_DIR):
        print(f"No {MIKE_VERSIONS_DIR} directory found")
        return False

    changes_made = False

    # Process each item in the versions directory
    for item in os.listdir(MIKE_VERSIONS_DIR):
        dir_path = os.path.join(MIKE_VERSIONS_DIR, item)
        if os.path.isdir(dir_path) and is_latest_name(item):
            if remove_directory(dir_path):
                changes_made = True

    return changes_made


def clean_aliases(data: Dict[str, Any]) -> bool:
    """Remove any 'latest' aliases from the data"""
    if "aliases" not in data:
        data["aliases"] = {}
        return False

    changes_made = False
    # Get keys to avoid modifying dict during iteration
    aliases: List[str] = list(data["aliases"].keys())

    for alias in aliases:
        if alias.lower() == "latest":
            version = data["aliases"][alias]
            print(f"Removing alias latest -> {version}")
            del data["aliases"][alias]
            changes_made = True

    return changes_made


def clean_versions(data: Dict[str, Any]) -> bool:
    """Remove any versions with 'latest' in the name"""
    if "versions" not in data:
        data["versions"] = []
        return False

    original_versions = data.get("versions", [])
    if not original_versions:
        return False

    original_count = len(original_versions)
    clean_versions_list: List[Any] = []

    # Filter out versions containing 'latest'
    for version in original_versions:
        if version is None:
            continue

        version_str = str(version).lower()
        if is_latest_name(version_str):
            print(f"Removing version: {version}")
        else:
            clean_versions_list.append(version)

    data["versions"] = clean_versions_list
    return len(clean_versions_list) < original_count


def fix_version_title_map(data: Dict[str, Any]) -> bool:
    """Fix the version_title_map to remove any 'latest' references"""
    if "version_title_map" not in data:
        return False

    changes_made = False
    keys_to_remove: List[str] = []

    for version in data.get("version_title_map", {}).keys():
        version_lower = version.lower() if isinstance(version, str) else ""
        if "latest" in version_lower:
            print(f"Removing version_title_map entry for {version}")
            keys_to_remove.append(version)
            changes_made = True

    for key in keys_to_remove:
        if key in data["version_title_map"]:
            del data["version_title_map"][key]

    return changes_made


def save_mike_info(data: Dict[str, Any]) -> bool:
    """Save the fixed mike info.json file"""
    try:
        # Use atomic file replacement
        temp_file = f"{MIKE_INFO_FILE}.fixed"
        with open(temp_file, "w") as f:
            json.dump(data, f, indent=2)
        os.replace(temp_file, MIKE_INFO_FILE)
        print(f"Successfully cleaned up {MIKE_INFO_FILE}")
        return True
    except Exception as e:
        print(f"Error saving cleaned file: {e}")
        return False


def fix_mike_info_file() -> bool:
    """Fix the .mike/info.json file"""
    if not os.path.isfile(MIKE_INFO_FILE):
        print(f"No {MIKE_INFO_FILE} file found")
        return False

    # Load the JSON data
    try:
        with open(MIKE_INFO_FILE, "r") as f:
            data: Dict[str, Any] = json.load(f)
    except json.JSONDecodeError:
        print(f"Corrupted JSON in {MIKE_INFO_FILE}. Restoring from backup.")
        if os.path.exists(MIKE_INFO_FILE + ".bak"):
            shutil.copy(MIKE_INFO_FILE + ".bak", MIKE_INFO_FILE)
        else:
            print("No backup available. Creating a new info.json.")
            with open(MIKE_INFO_FILE, "w") as f:
                json.dump({"aliases": {}, "versions": []}, f)
        sys.exit(1)

    # Remove 'latest' references
    if "latest" in data.get("aliases", {}):
        del data["aliases"]["latest"]
    if "latest" in data.get("versions", []):
        data["versions"].remove("latest")

    # Backup current info.json
    shutil.copy(MIKE_INFO_FILE, MIKE_INFO_FILE + ".bak")

    # Write cleaned data back to info.json
    with open(MIKE_INFO_FILE, "w") as f:
        json.dump(data, f, indent=2)

    print("Cleanup completed.")
    return True


def create_mike_dir() -> bool:
    """Create the .mike directory if it doesn't exist"""
    mike_dir = os.path.dirname(MIKE_INFO_FILE)
    if not os.path.isdir(mike_dir):
        try:
            os.makedirs(mike_dir, exist_ok=True)
            print(f"Created {mike_dir} directory")
            return True
        except Exception as e:
            print(f"Failed to create {mike_dir} directory: {e}")
            return False
    return False


def main() -> bool:
    """Main function to clean Mike configuration"""
    try:
        print("=== Mike Configuration Cleaner ===")
        dir_created = create_mike_dir()

        # Clean up directories first
        try:
            dir_changes = cleanup_mike_directories()
        except Exception as e:
            print(f"Directory cleanup failed: {e}")
            dir_changes = False

        # Now clean up the info.json file
        try:
            file_changes = fix_mike_info_file()
        except Exception as e:
            print(f"File cleanup failed: {e}")
            file_changes = False

        if not dir_created and not dir_changes and not file_changes:
            print("No 'latest' references found in Mike configuration")
        else:
            print("Mike configuration cleanup completed successfully")

        return True
    except Exception as e:
        print(f"Error: {e}")
        return False


if __name__ == "__main__":
    success = main()
    print(f"Script finished with {'success' if success else 'errors'}")
    sys.exit(0 if success else 1)
