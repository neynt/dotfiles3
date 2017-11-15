#!/usr/bin/env python3

# Automatic cloze-deletion of notes and spaced repetition flashcards.
# Saves progress to filename.save.

import argparse
import curses
import datetime
import hashlib
import heapq
import os
import pickle
import random
import re
import sys

parser = argparse.ArgumentParser(description='Quiz yourself cloze-deletion style.')
parser.add_argument('cloze_db_file', type=str, help='Name of cloze db file.')

unseen = []      # list of cards in the deck not in next_queue
next_queue = []  # heapq of cards to review
momentum = {}    # hash -> last timedelta added
questions = {}   # hash -> question text
answers = {}     # hash -> answer text (extremely denormalized)

# For brevity
delta = datetime.timedelta
def now():
    return datetime.datetime.now()
def pp_delta(δ):
    remaining = δ.total_seconds()
    seconds = remaining % 60
    remaining //= 60
    if remaining == 0:
        return '%ds' % seconds
    minutes = remaining % 60
    remaining //= 60
    if remaining == 0:
        return '%dm' % minutes
    hours = remaining % 24
    remaining //= 24
    if remaining == 0:
        return '%dh%02dm' % (hours, minutes)
    days = remaining
    return '%dd%02dh' % (days, hours)

def load_cards(filename):
    entries = open(filename).read().split('\n\n')
    for entry in entries:
        answer = re.sub(r'\[(.*?)]', r'\1', entry.strip())
        for keyword in set(re.findall(r'\[.*?\]', entry)):
            question = entry.replace(keyword[1:-1], '_' * (len(keyword) - 2))
            question = re.sub(r'\[(.*?)]', r'\1', question)
            key = hashlib.md5(question.encode('utf-8')).hexdigest()
            if key in questions:
                print("Warning: Duplicate question:\n" + question)
            unseen.append(key)
            questions[key] = question
            answers[key] = answer
            momentum[key] = delta(seconds=5)

def load_saved_data(filename):
    global unseen
    global next_queue
    global momentum
    try:
        save = pickle.load(open(filename, 'rb'))
        next_queue = save[0]
        momentum = save[1]
        for _, key in next_queue:
            if key in unseen:
                unseen.remove(key)

    except (FileNotFoundError, EOFError):
        pass

def save_data(filename):
    pickle.dump((next_queue, momentum), open(filename, 'wb'))

def pp_status_bar(w):
    card_times = []
    for next_time, next_hash in sorted(next_queue)[:3]:
        Δ = next_time - now()
        if Δ < delta(seconds=0):
            card_times.append('now')
        elif Δ < delta(days=30):
            card_times.append(pp_delta(Δ))

    cards_now = sum(1 for next_time, _ in next_queue if next_time < now())
    if cards_now:
        w.addstr('[ now: {} ]'.format(cards_now))

    if card_times:
        # [ next: 1m 17m 1h ]
        w.addstr('[ next: ')
        w.addstr(', '.join(card_times[:3]))
        w.addstr(' ({} total)'.format(len(next_queue)))
        #w.addstr(' ({} dbg) '.format(len(set(b for a,b in next_queue))))
        w.addstr(' ]')
    w.addstr('[ unseen: %d ]' % len(unseen))

def main_loop(w):
    while True:
        w.clear()
        while not unseen and (not next_queue or next_queue[0][0] > now()):
            w.addstr("You're all done for now. Next review in {}".format(
                pp_delta(next_queue[0][0] - now())))
            w.getkey()
            w.clear()
        pp_status_bar(w)
        if unseen and (not next_queue or next_queue[0][0] > now()):
            # Introduce a new question
            key = unseen.pop(random.randint(0, len(unseen)-1))
            w.addstr('[ new! ]')
            heapq.heappush(next_queue, (now(), key))
            momentum[key] = delta(seconds=0)

        old_time, key = next_queue[0]
        if key not in questions:
            heapq.heappop(next_queue)
            # Trim removed cards
            continue
        question = questions[key]
        answer = answers[key]
        w.addstr('\n\n')
        w.addstr(question)
        w.getkey()

        w.clear()
        pp_status_bar(w)
        w.addstr('\n\n')
        w.addstr(answer)
        w.addstr('\n\n')
        # TODO: Adaptive interval increase increases.
        interval_options = [
            ('1', delta(seconds=5)),
            ('2', momentum[key] * 1.5 + delta(minutes=1)),
            ('3', momentum[key] * 2.0 + delta(minutes=5)),
            ('4', momentum[key] * 3.0 + delta(minutes=15)),
            ('5', momentum[key] * 5.0 + delta(hours=1)),
            ('6', momentum[key] * 8.0 + delta(days=1)),
            ('7', momentum[key] * 13.0 + delta(days=7)),
        ]
        for cmd, interval in interval_options:
            w.addstr('{}: {}\n'.format(cmd, (pp_delta(interval))))
        w.addstr("9: never again\n")
        choice = None
        while not choice:
            ch = w.getch()
            for cmd, interval in interval_options:
                if ch == ord(cmd): choice = interval
            else:
                if ch == ord('9'): choice = momentum[key] + delta(days=100000)
        momentum[key] = choice
        heapq.heappop(next_queue)
        heapq.heappush(next_queue, (now() + momentum[key], key))

def cleanup(w):
    curses.nocbreak()
    w.keypad(False)
    curses.echo()
    curses.endwin()

def main(w, args):
    w = curses.initscr()
    curses.noecho()
    curses.cbreak()
    curses.curs_set(0)
    curses.use_default_colors()
    w.keypad(True)

    save_file_name = args.cloze_db_file + '.save'
    load_cards(args.cloze_db_file)
    load_saved_data(save_file_name)
    try:
        main_loop(w)
    except KeyboardInterrupt:
        cleanup(w)
    except curses.error:
        cleanup(w)
        print('Curses error. Window probably too small. Closing.')
    save_data(save_file_name)
    print('Saved to {}.'.format(save_file_name))

if __name__ == '__main__':
    args = parser.parse_args()
    curses.wrapper(main, args)
