#!/bin/sh

pvpn_file="${PVPN_STATUS_FILE:-$SMLSS_DATA_DIR/toggle-pvpn-status}"
[ ! -d "$(dirname "$pvpn_file")" ] && mkdir -p "$(dirname "$pvpn_file")"

get_last_pvpn_modify() {
	stat "$pvpn_file" | grep ^Modify | cut -d' ' -f2-
}

protoninfo() {
	# Timeout after 15 seconds, to prevent the statusbar being
	# frozen if a connection cannot be made.
	status="$(timeout 15 protonvpn status)"
	# If there is an error connecting to the VPN, then display some number
	# of exclamation points in the status bar and display a warning
	# notification.  Otherwise, display the VPN information as normal.
	if echo "$status" | grep -o '!'; then
		# Only show notification if the hardware kill switch isn't
		# flipped. In that case, the notification is just annoying.
		if ! nmcli radio | cut -d' ' -f1 | grep -q disabled; then
			dunstify -t 14500 -u 2 "$status"
		fi
	else
		echo "$status" | grep -E 'Server|Load' | awk '{print $2}' | \
			paste - - | tr '\t' ':'
	fi
}

keyinfo() {
	if setxkbmap -query | grep -q 'variant:    intl'; then
		echo 'INTL'
	else
		echo 'US'
	fi
}

# Print battery percentage, time remaining to full/dead, and status
batinfo() {
	if acpi 2>&1 | grep -qv 'No support for device type'; then
		acpi | awk '{
			# Do not end print statements with a newline
			ORS = ""

			# Remove the comma from the end of the percentage,
			# if it is present.
			sub(",", "", $4);

			# Replace the first colon with an hour label.
			# Replace the second colon with a minute label,
			# and also get rid of the seconds field.
			sub(":", "h", $5);
			sub(/:.*$/, "m", $5);

			print $4 " ";
			if (length($5) > 0)
				print $5 " ";

			if ($3 == "Charging,") {
				print "CHR"
			} else if ($3 == "Discharging,") {
				print "DRN"
			} else if ($3 == "Full,") {
				print "FULL"
			} else {
				print "?"
			}
		}'
	fi
}

dateinfo() {
	date '+%a %b %d %r %Y %Z'
}

set_status() {
	_batinfo="$(batinfo)"
	if echo "$_batinfo" | grep -q 'DRN$'; then
		percentage="$(echo "$_batinfo" | grep -o '^[0-9]*')"
		if [ "$percentage" -le 5 ]; then
			# Battery <= 5%. Flash warning and urgent colors.
			# The color changes on every tick of the loop below.
			# The color codes are determined by my dwm config.
			if [ "$flash_batinfo" ]; then
				_batinfo="$(printf '\x04')$_batinfo"
				flash_batinfo=
			else
				_batinfo="$(printf '\x03')$_batinfo"
				flash_batinfo=1
			fi
		elif [ "$percentage" -le 15 ]; then
			# Battery <= 15%. Display warning color.
			_batinfo="$(printf '\x03')$_batinfo"
		fi
	fi
	xsetroot -name "$proton $(keyinfo) $(vol) $(dateinfo) $_batinfo"
}

setxkbmap -option caps:escape

# This will probably be useful only on a Thinkpad X220 Tablet.
# The touch screen will not respond to touch from a finger, but it will still
# respond to the digitizer pen.
# I did this because it is annoying that things are clicked and higlighted
# when I am wiping dust off the screen.
xinput disable 'Wacom ISDv4 E6 Finger'

# `protonvpn status` takes an extra bit of time to run, so we don't want to
# update protonvpn info every second. For this reason, it is read into a
# variable which is only updated every "$imax" iterations.
imax=15
i="$imax"

# To change whether or not to print ProtonVPN status information in the status
# bar, users will touch this file. If it is detected that the file has been
# modified (`touch`-ed) since the last time it was checked, then this value
# will be toggled.
touch "$pvpn_file"
pvpn_last_modify="$(get_last_pvpn_modify)"
pvpn_status=1

# If Wi-Fi is present but disabled, don't print ProtonVPN status information.
ip link | grep wlp | grep -q 'state DOWN' && pvpn_status=

if [ ! "$WM" ]; then
	WM="dwm"
fi
if [ "$WM" = "dwm" ]; then
	while :; do
		pvpn_new_modify="$(get_last_pvpn_modify)"
		if [ "$pvpn_last_modify" != "$pvpn_new_modify" ]; then
			pvpn_last_modify="$pvpn_new_modify"
			if [ "$pvpn_status" ]; then
				pvpn_status=
			else
				# Set i so that if VPN status info is re-enabled, we
				# don't have to wait for i to reach imax as it starts
				# counting again to see VPN status info and receive '!'
				# notifications.
				i="$imax"
				pvpn_status=1
			fi
		fi

		if [ ! "$pvpn_status" ]; then
			proton="<>"
		elif [ "$i" -ge "$imax" ]; then
			# We append a space here to be in between proton and keyinfo,
			# if proton isn't empty.
			proton="$(protoninfo)" && [ -n "$proton" ] && proton="$proton "
			i=0
		else
			i="$(( i + 1 ))"
		fi
		set_status
		sleep 1
	done &
else  # openbox
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
