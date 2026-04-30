#!/usr/bin/env python3
"""
This script validates the MkDocs setup by checking the configuration file
and ensuring all required dependencies are installed.

Usage: python3 validate_mkdocs.py
"""
import os
import sys
import subprocess


def validate_mkdocs() -> None:
    try:
        # Check if mkdocs.yml exists
        if not os.path.isfile("mkdocs.yml"):
            print("Error: mkdocs.yml is missing in the repository root.")
            sys.exit(1)

        print("mkdocs.yml found.")

        # Check MkDocs installation
        result = subprocess.run(
            ["mkdocs", "--version"], capture_output=True, text=True
        )
        if result.returncode != 0:
            print("Error: MkDocs is not installed or not accessible.")
            sys.exit(1)

        print("MkDocs is installed:", result.stdout.strip())

        # Validate MkDocs configuration
        try:
            result = subprocess.run(
                ["mkdocs", "build", "--strict"],
                check=True,
                capture_output=True,
                text=True
            )
            print("MkDocs validation successful.")
            print(result.stdout)
        except subprocess.CalledProcessError as e:
            print("MkDocs validation failed.")
            print(e.stderr)
            sys.exit(1)

        print("MkDocs configuration is valid.")

    except Exception as e:
        print(f"Unexpected error: {e}")
        sys.exit(1)


if __name__ == "__main__":
    validate_mkdocs()
