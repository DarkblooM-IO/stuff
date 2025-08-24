#!/bin/env python
import sys, os, argparse

def trash(entries, empty):
    entries = " ".join(entries)
    nentries = len(entries)
    cmd = f"mv {entries} ~/.trash"

    if empty:
        cmd = "rm -rf ~/.trash/*"

    os.system(cmd)

def confirm() -> bool:
    return input("Are you sure? [y/N] ").strip().lower() in ["y","yes"]

parser = argparse.ArgumentParser(prog="trash")
parser.add_argument("entries", nargs="*", help="What will be moved to the trash")
parser.add_argument("-c", "--confirm", action="store_true", required=False, help="Prompt for confirmation before trashing")
parser.add_argument("-e", "--empty", action="store_true", required=False, help="Empty the trash")

def main() -> int:
    os.system("mkdir -p ~/.trash")
    args = parser.parse_args()
    nentries = len(args.entries)

    if nentries == 0 and not args.empty:
        os.system("tree -F ~/.trash")
        return 0

    if args.confirm:
        if not args.empty:
            print("Affected entries:")
            for e in args.entries:
                print(e)
        if confirm():
            trash(args.entries, args.empty)
            return 0
        return 1

    trash(args.entries, args.empty)
    return 0

if __name__ == "__main__":
    sys.exit(main())
