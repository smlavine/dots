#!/bin/sh

setxkbmap -option caps:escape

# This will probably only be useful on a Thinkpad Tablet.
# This will make it so that the touch screen will not respond to touch from a
# finger, but will still respond to a digitizer pen.
# I did this because it is annoying that things are clicked and higlighted
# when I am wiping dust off the screen.
xinput list --name-only | grep Finger | xargs -I{} xinput disable {}

if [ ! "$WM" ]; then
	WM="dwm"
fi

if [ "$WM" = "dwm" ]; then
	dwmblocks &
elif [ "$WM" = "openbox" ]; then
	tint2 &
fi

# Happy Holidays!
xsetroot -bitmap /usr/include/X11/bitmaps/xsnow -bg rgb:14/13/7E -fg rgb:2A/89/F5

# Limit my desktop monitor to 2048x1152 -- text looks too small on 2560x1440
if xrandr | grep -q 'HDMI-0 connected'; then
	xrandr --output HDMI-0 --mode 2048x1152
fi

dunst &

exec "$WM"
