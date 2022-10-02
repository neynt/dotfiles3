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

### eGPU

When using a Mantiz Saturn II eGPU with an RX 580, I was encountering this issue
where the external display (HP Z27 at 4k60) was being refreshed really slowly
and choppily; according to the OSD, it was H=22.2kHz V=10Hz. Here's how I got it
working properly.

Install `xf86-video-amdgpu` and [maybe some other
things](https://wiki.archlinux.org/index.php/AMDGPU).

Put the following in `/etc/X11/xorg.conf.d/20-amdgpu.conf`:

```xf86conf
Section "Device"
  Identifier "AMD"
  Driver "amdgpu"
  BusID "PCI:11:0:0"
EndSection
```

Add the following kernel params to `/etc/default/grub`:

```
amdgpu.dpm=0 amdgpu.aspm=0 amdgpu.runpm=0 amdgpu.bapm=0
```

It still sometimes doesn't resume properly but it works fairly consistently
after a reboot.

### GNOME shell extensions

I don't use GNOME shell anymore but when I did, I used these extensions:

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

Half of these need hotfixes because GNOME 3 is ruthless to extension developers.

### MacOS

I capitulated. Useful apps:

- Rectangle
- LinearMouse
