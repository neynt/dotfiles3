#!/usr/bin/env python3

# Uses scanmem to cheat at flash games using AoBs.

import subprocess
import sys
import time
from queue import Queue, Empty
from threading import Thread

def main():
    if len(sys.argv) <= 3:
        print(f'Usage: {sys.argv[0]} pid aob_before aob_after')
        return
    
    pid = sys.argv[1]
    aob_before = sys.argv[2]
    aob_after = sys.argv[3]

    proc = subprocess.Popen(['scanmem', pid],
            stdin=subprocess.PIPE,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            encoding='utf-8',
            bufsize=1,
            close_fds=True)

    def enqueue_output(out, queue):
        for line in iter(out.readline, b''):
            queue.put(line)
        out.close()

    # https://stackoverflow.com/questions/375427/
    q = Queue()
    t1 = Thread(target=enqueue_output, args=(proc.stdout, q))
    t1.daemon = True
    t1.start()

    t2 = Thread(target=enqueue_output, args=(proc.stderr, q))
    t2.daemon = True
    t2.start()

    def put(x, timeout=0.1):
        print(x)
        proc.stdin.write(x)
        out = ''
        last_data_time = time.time()
        while True:
            try:
                addl = q.get_nowait()
                print(addl, end='')
                out += addl
                last_data_time = time.time()
            except Empty:
                if time.time() - last_data_time > timeout:
                    break
                time.sleep(0.01)
        return out

    put('option scan_data_type bytearray\n')

    out = put(f'{aob_before}\n', timeout=0.5)
    if '0 matches' in out:
        print('Error: could not find original AOB.')
        return

    out = put('list\n')
    lines = out.splitlines()
    for line in lines:
        try:
            mem_addr = line.split(']')[1].strip().split(',')[0]
            put(f'write bytearray {mem_addr} {aob_after}\n', timeout=0.1)
        except IndexError:
            pass
    time.sleep(1)
    proc.terminate()

if __name__ == '__main__':
    main()
