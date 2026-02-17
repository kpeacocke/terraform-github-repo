#!/usr/bin/env python3
import os
import json
import shutil
import sys

# Set up test environment
os.environ["MIKE_INFO_FILE"] = "test_mike/info.json"
os.environ["MIKE_VERSIONS_DIR"] = "test_mike/versions"

# Import the actual script
sys.path.append("scripts")
from fix_mike_info import main

# Run the script
result = main()
print(f"Script returned: {result}")

# Show results
print("\nContents of test_mike/versions after cleaning:")
print(os.listdir("test_mike/versions"))

print("\nContents of test_mike/info.json after cleaning:")
with open("test_mike/info.json", "r") as f:
    print(json.dumps(json.load(f), indent=2))
