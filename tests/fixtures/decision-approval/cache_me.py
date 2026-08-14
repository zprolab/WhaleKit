#!/usr/bin/env python3
"""cache-me: runs an external command and prints its output (fixture for decision-approval tests)."""
import subprocess
import sys


def run(cmd):
    print(f"$ {cmd}")
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    print(result.stdout, end="")
    if result.stderr:
        print(result.stderr, file=sys.stderr, end="")
    return result.returncode


if __name__ == "__main__":
    sys.exit(run(" ".join(sys.argv[1:])))
