#!/bin/sh

pvpn_file="${PVPN_STATUS_FILE:-$XDG_DATA_HOME/smlss/toggle-pvpn-status}"
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
		dunstify -t 14500 -u 2 "$status"
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

batinfo() {
	# Print battery percentage, time remaining to full/dead, and status
	acpi 2>&1 | grep -q 'No support for device type' ||
		echo -n "$( acpi |
			awk '{print $4 $5}' |
			sed 's/:[0-9]*$/m/;s/:/h/' |
			tr ',' ' ') " &&
		case "$(acpi | awk '{print $3}')" in
			Charging,)    echo CHR ;;
			Discharging,) echo DRN ;;
			Full,)        echo FULL ;;
			*)            echo ? ;;
		esac
}

dateinfo() {
	date '+%a %b %d %r %Z'
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

while true
do
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
		proton="<> "
	elif [ "$i" -ge "$imax" ]; then
		# We append a space here to be in between proton and keyinfo,
		# if proton isn't empty.
		proton="$(protoninfo)" && [ -n "$proton" ] && proton="$proton "
		i=0
	else
		i="$(( i + 1 ))"
	fi
	xsetroot -name " $proton$(keyinfo) $(vol) $(dateinfo) $(batinfo)"
	sleep 1
done &

dunst -font "monospace 11" &

# Happy Holidays!
xsetroot -bitmap /usr/include/X11/bitmaps/xsnow -bg rgb:14/13/7E -fg rgb:2A/89/F5

exec dwm
