#!/usr/bin/python3
letters = 'abcdefghijklmnopqrstuvwxyz'
spellings = '''a bee cee dee e ef gee aitch i jay kay el em en o pee cue ar ess
tee u vee double-u ex wy zee'''.split()

mapping = dict(zip(letters, spellings))
mapping.update({
    ' ': 'space',
    "'": 'apostrophe',
    '.': 'period',
})
rmapping = {b:a for a,b in mapping.items()}

def spellout(word):
    return ' '.join(mapping.get(c, c) for c in word)

def spellin(spelling):
    return ''.join(rmapping.get(c, c) for c in spelling.split())

if __name__ == '__main__':
    try:
        while True:
            print(spellout(input()))
    except:
        pass
