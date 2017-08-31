## dotfiles3

Dotfiles that I can take anywhere.

### Installing

`install.sh` lets you symlink a single dotfile at a time.

```
$ ./install.sh .vimrc
$ ./install.sh .vim/colors
```

You will be asked before the script tries to delete any files that already
exist.

### Tracking new config files

To copy an existing file or directory to this repo:

```
$ ./take.sh ~/.vimrc
$ ./take.sh ~/.vim/colors
```

Then, use `install.sh` to replace the original files with a symlink.
