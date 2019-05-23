#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx

userxres="$HOME/.Xresources"
usercxres="$HOME/.config/xresources/Xresources"
userxdef="$HOME/.Xdefaults"
usermodmap="$HOME/.Xmodmap"
sysres="/etc/X11/xinit/.Xresources"
sysmodmap="/etc/X11/xinit/.Xmodmap"

[ -f "$sysmodmap" ] && xmodmap "$sysmodmap"
[ -f "$usermodmap" ] && xmodmap "$usermodmap"
[ -f "$sysres" ] && xrdb -merge "$sysres"
[ -f "$userxdef" ] && xrdb -merge "$userxdef"
[ -f "$userxres" ] && xrdb -merge "$userxres"
[ -f "$usercxres" ] && xrdb -merge "$usercxres"

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

exec i3
