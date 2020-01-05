#!/usr/bin/env python3
from collections import Counter
import functools
import queue

def score(length):
    if length <= 2: return 1
    elif length == 3: return 3
    elif length == 4: return 5
    elif length == 5: return 10
    elif length == 6: return 20
    elif length == 7: return 30
    elif length == 8: return 50

# permitted operations:
# - insert letter (5)
# - remove letter (5)
# - swap letters (distance between them)

def nearest(letter, word, i):
    best = len(word)
    best_j = None
    for j, letter_ in enumerate(word):
        if letter == letter_:
            best = min(best, abs(i - j))
            best_j = j
    return best, best_j

@functools.lru_cache(None)
def distance(word1, word2):
    result = 0
    word2 = list(word2)
    for i, letter1 in enumerate(word1):
        if letter1 in word2:
            dist, j = nearest(letter1, word2, i)
            result += min(5, dist)
            word2[j] = None
        else:
            result += 5
    return result

letters = Counter(input().lower())
words = []
for word in open('/usr/share/dict/words').read().split():
    word = word.lower()
    if not (Counter(word) - letters):
        words.append(word)

words.sort()
words.sort(key=len)
#for word in words:
#    print(word)

words = [word for word in words if 5 <= len(word) <= 8]
paths = queue.PriorityQueue()
paths.put((0, 0, ['']))

done_paths = []

while len(done_paths) < 50000:
    neg_score, dist, path = paths.get_nowait()
    if dist > 120:
        done_paths.append((-neg_score, dist, path))
        continue
    for next_word in words:
        if next_word in path: continue
        next_neg_score = neg_score - score(len(next_word))
        next_dist = dist + distance(path[-1], next_word)
        paths.put((next_neg_score, next_dist, path + [next_word]))

done_paths.sort()
for path in done_paths[:-10]:
    print(path)
