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

## Other scripts

`./mkcolors.py` searches for .tmpl files and generates files without the .tmpl
extension with variables like `$color4_csv` substituted appropriately.

`./mkcompose.py > .XCompose` generates an .XCompose file from bindings
expressed in Python.

## Other configuration

### GNOME shell extensions

- Activities configurator
- Alternatetab
- Always zoom workspaces
- Disable workspace switcher popup
- Hide top bar
- Launch new instance
- Native window placement
- Status area horizontal spacing
- Topicons plus
- User themes
- Shellshape

Half of these need hotfixes because GNOME 3 is ruthless to extension
developers.
