#!/usr/bin/env python3
from collections import Counter
import queue

letters = Counter(input().lower())
words = []
for word in open('/usr/share/dict/words').read().split():
    word = word.lower()
    if not (Counter(word) - letters):
        words.append(word)

words.sort()
words.sort(key=len)
for word in words:
    print(word)
