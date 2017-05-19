#!/usr/bin/env python3

class Workspaces():
  prefix = 'W'
  desktop_colors = { # bg, fg
    'o': ('#333333', '#888888'),
    'O': ('#333333', '#ffffff'),
    'f': ('#000000', '#888888'),
    'F': ('#000000', '#ffffff'),
    'u': ('#333333', '#888888'),
    'U': ('#333333', '#ffffff')
  }

  def __init__(self):
    self.status = ""

  def update(self, line):
    new_status = ""
    for part in line.split(':'):
      pre = part[0]
      name = part[1:]
      if pre in self.desktop_colors:
        bg, fg = self.desktop_colors[pre]
        new_status += "%{{F{}}}%{{B{}}} {} %{{B-}}%{{F-}}".format(fg, bg, name)
      elif pre == 'M': # active monitor
        pass
      elif pre == 'm': # inactive monitor
        pass
    self.status = new_status

  def render(self):
    return '{}'.format(self.status)

class Clock():
  prefix = 'C'
  def __init__(self):
    self.cur_time = ""

  def update(self, line):
    self.cur_time = line

  def render(self):
    return '%{{c}}{}'.format(self.cur_time)

def main():
  widgets = [
      Workspaces(),
      Clock()
  ]
  widgets_by_prefix = {w.prefix: w for w in widgets}

  while True:
    line = input()
    prefix = line[0]
    if prefix in widgets_by_prefix:
      widgets_by_prefix[prefix].update(line[1:])
    print(' '.join(w.render() for w in widgets))

if __name__ == '__main__':
  main()
