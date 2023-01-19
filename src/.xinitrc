#!/bin/sh

setxkbmap -option caps:escape

# This will probably be useful only on a Thinkpad X220 Tablet.
# The touch screen will not respond to touch from a finger, but it will still
# respond to the digitizer pen.
# I did this because it is annoying that things are clicked and higlighted
# when I am wiping dust off the screen.
xinput disable 'Wacom ISDv4 E6 Finger'

if [ ! "$WM" ]; then
	WM="dwm"
fi

if [ "$WM" = "dwm" ]; then
	dwmblocks &
else  # openbox
	tint2 &
fi

# Happy Holidays!
xsetroot -bitmap /usr/include/X11/bitmaps/xsnow -bg rgb:14/13/7E -fg rgb:2A/89/F5

# Limit my desktop monitor to 2048x1152 -- text looks too small on 2560x1440
if xrandr | grep -q 'HDMI-0 connected'; then
	xrandr --output HDMI-0 --mode 2048x1152
fi

dockd --daemon &
sleep 0.5

# Set the correct monitor configuration if DP-2 is connected (which means that
# we are on my ThinkPad laptop, connected to a dock)
if xrandr | grep -q 'DP-2 connected'; then
	dockd --set docked
fi

dunst &

exec "$WM"
