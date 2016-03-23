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
# sh ~/.fehbg &
xmodmap -e "keycode 66 = Control_L" &
xcape -e '#66=Escape' &

exec cinnamon-session
#exec swm
