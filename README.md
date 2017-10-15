# dotfiles3

Dotfiles that I can take anywhere.

## Installing

`install.sh` symlinks a single file or directory from your home directory to
this repo.

```
$ ./install.sh .vimrc
$ ./install.sh .vim/colors
```

You will be asked before the script tries to delete any files that already
exist.

## Tracking new config files

To copy an existing file or directory to this repo:

```
$ ./take.sh ~/.vimrc
$ ./take.sh ~/.vim/colors
```

Then, use `install.sh` to replace the original files with a symlink.

## Colors

`./mkcolors.py` searches for .tmpl files and generates files without the .tmpl
extension with variables like `$color4_csv` substituted appropriately.

## Other configuration

### GNOME shell extensions

- Activities configurator
- Alternatetab
- Disable workspace switcher popup
- Impatience
- Launch new instance
- Native window placement
- Status area horizontal spacing
- Topicons plus
- User themes
- Shellshape
