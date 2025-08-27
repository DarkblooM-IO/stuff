#!/usr/bin/env python
import argparse, re, sys

parser = argparse.ArgumentParser(prog="grep")
parser.add_argument("pattern", help="Regex to search for")
parser.add_argument("file", help="File to search through")
args = parser.parse_args()

def main() -> int:
    file = None
    try:
        file = open(args.file, "r")
    except FileNotFoundError:
        print(f"couldn't find file {args.file}")
        return 1

    pattern = re.compile(args.pattern)

    for line in file:
        if pattern.search(line):
            print(line.strip())

    file.close()

    return 0

if __name__ == "__main__":
    sys.exit(main())
