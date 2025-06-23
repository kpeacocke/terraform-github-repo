import argparse
import subprocess
import sys


def deploy_docs(version: str) -> None:
    try:
        print(f"Deploying versioned documentation for version: {version}")

        # Check and resolve alias conflicts
        print("Checking for alias conflicts...")
        subprocess.run(["mike", "delete", "latest"], check=False)

        # Run Mike commands to deploy documentation
        subprocess.run(["mike", "deploy", version, "latest"], check=True)
        subprocess.run(["mike", "set-default", "latest"], check=True)

        print("Documentation deployed successfully!")
    except subprocess.CalledProcessError as e:
        print(f"Error during deployment: {e}")
        sys.exit(1)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Deploy versioned documentation using Mike."
    )
    parser.add_argument(
        "--version", required=True, help="Version to deploy"
    )
    args = parser.parse_args()

    deploy_docs(args.version)
