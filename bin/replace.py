#!/usr/bin/env python3
"""Replace file content based on python regexes and format strings."""

C_RED = '\033[91m'
C_GREEN = '\033[92m'
C_RESET = '\033[0m'

import argparse
import re
import os
import itertools

parser = argparse.ArgumentParser(description='Find/replace using Python regexes and format strings.')
parser.add_argument('orig_format', metavar='ORIG_REGEX', type=str,
                    help='regex for the original format of what to search for')
parser.add_argument('new_format', metavar='NEW_FORMAT', type=str,
                    help='format string for the new format of the file name')
parser.add_argument('files', nargs='+', help='files to rename')
parser.add_argument('-d', '--dry', action='store_true',
                    help="don't actually modify the files")
parser.add_argument('-t', '--transform', metavar='LAMBDA', type=str, action='append',
                    help='create an additional format arg by transforming the '
                         'existing format args using LAMBDA')

def main():
    args = parser.parse_args()
    pattern = re.compile(args.orig_format, re.DOTALL)

    # Eval transformation functions, if any
    transforms = []
    if args.transform:
        for fn_def in args.transform:
            transforms.append(eval('lambda ' + fn_def))

    # Replace files!
    for filename in args.files:
        content = open(filename).read()
        # Find one to determine the number of groups
        one_match = pattern.search(content)
        if not one_match:
            print(f'=== {filename} === (no changes)')
            continue
        print(f'=== {filename} ===')
        n = len(one_match.groups())

        # Find all so we know what they originally looked like
        orig_matches = [m.group(0) for m in pattern.finditer(content)]

        parts = pattern.split(content)

        demo_parts = []
        new_parts = []

        for xs, orig_match in itertools.zip_longest(itertools.zip_longest(*[parts[i::n+1] for i in range(n+1)]), orig_matches):
            orig_text = xs[0]
            orig_text_lines = orig_text.splitlines()
            if len(orig_text_lines) <= 6:
                demo_parts.append(orig_text)
            else:
                demo_parts.append('\n'.join(orig_text_lines[:3]))
                demo_parts.append('\n...\n')
                demo_parts.append('\n'.join(orig_text_lines[-3:]))
            new_parts.append(orig_text)

            match_parts = xs[1:]
            if orig_match:
                match_parts = [x if x else '' for x in match_parts]
                result = args.new_format.format(*match_parts)
                new_parts.append(result)
                demo_parts.append(C_RED + orig_match)
                demo_parts.append(C_GREEN + result)
                demo_parts.append(C_RESET)

        print(''.join(demo_parts))

        if not args.dry:
            new_content = ''.join(new_parts)
            open(filename, 'w').write(new_content)

if __name__ == '__main__':
    main()
