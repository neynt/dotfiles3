#!/usr/bin/env python3
import time
import datetime

def pprint_timedelta(td):
    s = td.total_seconds()
    parts = []
    for name, amt in [('s', 60), ('m', 60), ('h', 24), ('d', 99999)]:
        xx = s % amt
        s = round(s - xx) // amt
        if name == 's':
            parts.append(f'{xx:.1f}{name}')
        else:
            parts.append(f'{xx}{name}')
        if s == 0:
            break
    return ''.join(reversed(parts))

start = datetime.datetime.now()
while True:
    elapsed = datetime.datetime.now() - start
    print(f'\r{pprint_timedelta(elapsed)}', end='')
    time.sleep(0.1)
