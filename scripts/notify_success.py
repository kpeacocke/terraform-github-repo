import sys


def notify_success(version: str) -> None:
    print(f"✅ Successfully released version {version}!")
    # Add logic to send notifications (e.g., Slack, email, etc.)


def main() -> None:
    import argparse
    parser = argparse.ArgumentParser(description="Notify success script")
    parser.add_argument(
        "--version", required=True, help="Version to notify about"
    )
    args = parser.parse_args()

    notify_success(args.version)


if __name__ == "__main__":
    try:
        main()
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
