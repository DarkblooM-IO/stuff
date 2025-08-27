#!/usr/bin/env python
import argparse, re

parser = argparse.ArgumentParser(prog="grep")
parser.add_argument("pattern", help="Regex to search for")
parser.add_argument("file", help="File to search through")
args = parser.parse_args()

def main():
    pattern = re.compile(args.pattern)
    with open(args.file, "r") as file:
        for line in file:
            if pattern.search(line):
                print(line.strip())

if __name__ == "__main__":
    main()
