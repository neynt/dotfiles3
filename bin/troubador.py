#!/usr/bin/env python3

# troubador: Generates password-like variations on a base word in rough order
# of likelihood.

import itertools
import sys
import heapq

# Given [[(cost, item)]], yield (total cost, set of item) in order of ascending
# total cost. Assume positive costs.
def subsets_by_cost(items):
    if not items:
        yield (0, [])
        return
    results = []
    for total_cost, item_set in subsets_by_cost(items[1:]):
        while results and results[0][0] < total_cost:
            yield heapq.heappop(results)
        for cost, item in items[0]:
            heapq.heappush(results, (total_cost + cost, [item] + item_set))
    while results:
        yield heapq.heappop(results)

def subsets_by_cost_example():
    fruits = [(1, 'apple'), (1, 'cherry'), (2, 'pineapple'), (5, 'grapefruit')]
    pastries = [(10, 'cake'), (20, 'pie'), (30, 'tart')]
    meals = [(5, 'dinner'), (6, 'dessert'), (100, 'breakfast')]

    # Starts with "apple cake dinner", ends with "grapefruit tart breakfast"
    print(list(subsets_by_cost([fruits, pastries, meals])))

# Triples of (application order, unique id, function)
# The unique id prevents functions from being compared (which is an exception)
fn_ids = itertools.count()
noop = (0, next(fn_ids), lambda x: x)
def replace_i(i, c):
    return (0, next(fn_ids), lambda s: s[:i] + c + s[i+1:])
def append_str(c):
    return (1, next(fn_ids), lambda s: s + c)
def prepend_str(c):
    return (1, next(fn_ids), lambda s: c + s)

common_substitutions = {
    'a': '@4',
    'e': '3',
    'g': '9',
    'i': '1!',
    'o': '0',
    's': '5$',
    't': '7',
}

uncommon_substitutions = {
    'b': '8',
    'g': '6',
    'i': '89',
    'l': '1',
    'z': '257',
}

# TODO: extend
punctuation = '!@#$%^&*_=~'
digits = '0123456789'

def append_cost(s):
    cost = len(s) * len(s)
    for c in s:
        if c.isdecimal():
            cost += 1
        else:
            cost += 5
    return cost

def main(word):
    mutations = []
    for i, c in enumerate(word):
        mutations_char = [(0, noop)]
        # Uppercase a letter.
        # If the letter is already uppercase, we assume it is known to be uppercase.
        if c.islower():
            cost = 1 if i == 0 else 7
            mutations_char.append((cost, replace_i(i, c.upper())))
        # Common substitutions
        for c in common_substitutions.get(c.lower(), []):
            cost = 1 if i == 0 else 2
            mutations_char.append((cost, replace_i(i, c)))
        for c in uncommon_substitutions.get(c.lower(), []):
            cost = 5 if i == 0 else 10
            mutations_char.append((cost, replace_i(i, c)))
        mutations.append(mutations_char)

    mutations_append = [(0, noop)]
    for num_chars in [1, 2, 3]:
        for chars in itertools.product(*([punctuation + digits] * num_chars)):
            chars = ''.join(chars)
            mutations_append.append((append_cost(chars), append_str(chars)))
    mutations.append(mutations_append)

    for _total_cost, fs in subsets_by_cost(mutations):
        word_ = word
        for _, _, f in sorted(fs):
            word_ = f(word_)
        print(word_)

if __name__ == '__main__':
    if len(sys.argv) <= 1:
        while True:
            main(input())
    else:
        for word in sys.argv[1:]:
            main(word)
