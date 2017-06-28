#!/usr/bin/env python3
"""Rename files in current directory based on python regexes and format strings.

Examples:

$ rename.py 'Goodnight Punpun v(\d+) c(\d+) - (\d+).png' '{0}.{1}.{2}.png'
changes "Goodnight Punpun v01 c02 - 012.png"
to      "01.02.012.png"

$ rename.py 'IMG_(\d+).jpg' '{1}.jpg' -t 'x: int(x)+1'
changes "IMG_6969.jpg"
to      "IMG_6970.jpg"
"""

import argparse
import re
import os

parser = argparse.ArgumentParser(description='Mass regex rename of files.')
parser.add_argument('orig_format', metavar='ORIG_REGEX', type=str,
                    help='python regex for the original format of the file name')
parser.add_argument('new_format', metavar='NEW_FORMAT', type=str,
                    help='python format string for the new format of the file name')
parser.add_argument('-d', '--dry', action='store_true',
                    help="don't actually rename the files")
parser.add_argument('-t', '--transform', metavar='LAMBDA', type=str, action='append',
                    help='create an additional format arg by transforming the'
                         'existing format args using LAMBDA')

def main():
    args = parser.parse_args()
    pattern = re.compile(args.orig_format)

    # Eval transformation functions, if any
    transforms = []
    if args.transform:
        for fn_def in args.transform:
            transforms.append(eval('lambda ' + fn_def))

    renames = []

    files = os.listdir()
    for filename in files:
        match = pattern.match(filename)
        if match:
            groups = list(match.groups())
            for f in transforms:
                groups.append(f(*groups))
            new_filename = args.new_format.format(*map(str, groups))
            renames.append((filename, new_filename))

    renames.sort()
    for filename, new_filename in renames:
        print('OLD: ' + filename)
        print('NEW: ' + new_filename)

    if len(set([new_filename for _, new_filename in renames])) != len(renames):
        print('Error: Some files will be renamed to the same thing!')
    elif args.dry:
        print('Files unchanged.')
    else:
        for filename, new_filename in renames:
            os.rename(filename, new_filename)
        print('Files renamed.')

if __name__ == '__main__':
    main()
