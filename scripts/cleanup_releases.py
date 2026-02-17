import sys


def cleanup_releases(keep: int) -> None:
    print(f"Cleaning up old releases, keeping the latest {keep}.")
    # Add logic to delete old releases from the repository or storage


def main() -> None:
    import argparse
    parser = argparse.ArgumentParser(description="Cleanup old releases script")
    parser.add_argument(
        "--keep", type=int, required=True,
        help="Number of latest releases to keep"
    )
    args = parser.parse_args()

    cleanup_releases(args.keep)


if __name__ == "__main__":
    try:
        main()
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
