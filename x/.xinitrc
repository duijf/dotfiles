#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

if [ -s ~/.Xmodmap ]; then
  xmodmap ~/.Xmodmap
fi

xrdb -merge ~/.Xresources
sxhkd -c ~/.sxhkdrc > /dev/null 2>&1 &
sh ~/.fehbg &
xcape &
python ~/bin/battery.py &
exec swm
