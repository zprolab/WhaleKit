#!/usr/bin/env python3
"""cli-bookmark: minimal command-line bookmark manager (fixture for clarification-questioner tests)."""
import argparse
import json
import os
import sys

DATA_FILE = os.path.expanduser("~/.cli_bookmarks.json")


def load_bookmarks():
    if not os.path.exists(DATA_FILE):
        return []
    with open(DATA_FILE) as f:
        return json.load(f)


def save_bookmarks(items):
    with open(DATA_FILE, "w") as f:
        json.dump(items, f, indent=2)


def cmd_add(args):
    items = load_bookmarks()
    items.append({"title": args.title, "url": args.url})
    save_bookmarks(items)
    print(f"added: {args.title}")


def cmd_list(args):
    items = load_bookmarks()
    if not items:
        print("(empty)")
        return
    for i, it in enumerate(items, 1):
        print(f"{i}. {it['title']}  {it['url']}")


def cmd_remove(args):
    items = load_bookmarks()
    idx = int(args.index) - 1
    if 0 <= idx < len(items):
        removed = items.pop(idx)
        save_bookmarks(items)
        print(f"removed: {removed['title']}")
    else:
        print("bad index", file=sys.stderr)


def main():
    parser = argparse.ArgumentParser(prog="bm")
    sub = parser.add_subparsers(dest="cmd", required=True)
    p_add = sub.add_parser("add")
    p_add.add_argument("title")
    p_add.add_argument("url")
    p_add.set_defaults(fn=cmd_add)
    p_list = sub.add_parser("list")
    p_list.set_defaults(fn=cmd_list)
    p_rm = sub.add_parser("rm")
    p_rm.add_argument("index")
    p_rm.set_defaults(fn=cmd_remove)
    args = parser.parse_args()
    args.fn(args)


if __name__ == "__main__":
    main()
