#!/usr/bin/python3
# Searches paths for .tmpl files and substitutes the correct colours.
import glob
import itertools
import string
import os

# List of all color template strings available:
# ${COLOR}_hex: e.g. #ff0000
# ${COLOR}_csv: e.g. 255,0,0
#
# ${COLOR} is a key in the colors dict.
# Append _bright to the key for the bright variant of the color, e.g.
# color1_bright_hex is the hex for bright red.

colors = {
    # Color name    Normal     Bright
    'background': ['#000000', '#000000'],
    'foreground': ['#e9e9e9', '#ffffff'],
    'color0':     ['#222222', '#5d5d5d'], # Black
    'color1':     ['#c75646', '#e09690'], # Red
    'color2':     ['#8eb33b', '#cdee69'], # Green
    'color3':     ['#d0b03c', '#ffe377'], # Yellow
    'color4':     ['#72b3cc', '#9cd9f0'], # Blue
    'color5':     ['#c8a0d1', '#fbb1f9'], # Purple
    'color6':     ['#218693', '#77dfd8'], # Cyan
    'color7':     ['#b0b0b0', '#ffffff'], # White
}

paths = [
    '.*.tmpl',
    '.config/**/*.tmpl',
    '.local/**/*.tmpl',
    '**/*.tmpl',
]

def hex2rgb(hex_color):
    rx, gx, bx = (hex_color[1:3], hex_color[3:5], hex_color[5:7])
    return int(rx, 16), int(gx, 16), int(bx, 16)

def rgb2hex(r, g, b): return '#%02x%02x%02x' % (r, g, b)
def rgb2csv(r, g, b): return '%d,%d,%d' % (r, g, b)

# Pass 1: Transform colors into a flat dict, with bright variants
# renamed to, e.g. 'color1_bright'.
colors_flat_rgb = {}
for color_name, (normal_hex, bright_hex) in colors.items():
    normal_rgb = hex2rgb(normal_hex)
    bright_rgb = hex2rgb(bright_hex)
    colors_flat_rgb[color_name] = normal_rgb
    colors_flat_rgb[color_name + '_bright'] = bright_rgb

# Pass 2: Generate the template names.
tmpl_subs = {}
for color_name, rgb in colors_flat_rgb.items():
    tmpl_subs[color_name + '_hex'] = rgb2hex(*rgb)
    tmpl_subs[color_name + '_csv'] = rgb2csv(*rgb)

# Apply the templates to all .tmpl files!
filenames = itertools.chain(
        *[glob.iglob(path, recursive=True) for path in paths])
for filename in filenames:
    print(filename)
    new_filename = os.path.splitext(filename)[0]
    tmpl = string.Template(open(filename).read())
    new_content = tmpl.substitute(tmpl_subs)
    open(new_filename, 'w').write(new_content)
