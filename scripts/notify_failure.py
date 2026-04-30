import sys


def notify_failure(version: str) -> None:
    print(f"❌ Release of version {version} failed!")
    # Add logic to send failure notifications (e.g., Slack, email, etc.)


def main() -> None:
    import argparse
    parser = argparse.ArgumentParser(description="Notify failure script")
    parser.add_argument(
        "--version", required=True, help="Version to notify about"
    )
    args = parser.parse_args()

    notify_failure(args.version)


if __name__ == "__main__":
    try:
        main()
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
