## dotfiles3

Dotfiles that I can take anywhere.

### Installing

To symlink a file or directory to this repo's directory:

```
$ ./install.sh .vimrc
$ ./install.sh .vim/colors
```

You will be asked before the script tries to delete any files that already
exist.

### Tracking new config files

To copy an existing file or directory to the repo:

```
$ ./take.sh ~/.vimrc
$ ./take.sh ~/.vim/colors
```

Then, use `install.sh` to symlink the original files.
