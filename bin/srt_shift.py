#!/usr/bin/env python3
import sys
import re
import itertools

if len(sys.argv) == 2:
    shift_ms = int(sys.argv[1])
    content = sys.stdin.read()
elif len(sys.argv) == 3:
    shift_ms = int(sys.argv[2])
    content = open(sys.argv[1]).read()
else:
    print(f'usage: {sys.argv[0]} [filename] shift_ms')
    sys.exit(1)

timestamp = re.compile(r'(\d\d):(\d\d):(\d\d),(\d\d\d)')
g = 5
parts = timestamp.split(content)
new_parts = []

for part, hh, mm, ss, mss in itertools.zip_longest(*[parts[i::g] for i in range(g)]):
    new_parts.append(part)
    if hh:
        hh, mm, ss, mss = map(int, [hh, mm, ss, mss])
        ms = 0
        coefs = [60, 60, 1000]
        ms += hh; ms *= 60
        ms += mm; ms *= 60
        ms += ss; ms *= 1000
        ms += mss
        ms += shift_ms
        mss = ms % 1000; ms //= 1000;
        ss = ms % 60; ms //= 60;
        mm = ms % 60; ms //= 60;
        hh = ms
        new_parts.append(f'{hh:02d}:{mm:02d}:{ss:02d},{mss:03d}')

print(''.join(new_parts), end='')
