#!/bin/sh

protoninfo() {
	status="$(protonvpn status)"
	# If there is an error connecting to the VPN, then display some number of
	# exclamation points in the status bar and display a warning notification.
	# Otherwise, display the VPN information as normal.
	if echo "$status" | grep -o '!'; then
		dunstify -t 14500 -u 2 "$status"
	else
		echo "$status" | grep -E 'Server|Load' | awk '{print $2}' | \
			paste - - | tr '\t' ':'
	fi
}

keyinfo() {
	setxkbmap -query | grep -q 'variant:    intl' && echo 'INTL' || echo 'US'
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
	echo $(date '+%a %b %d %r %Z')
}

setxkbmap -option caps:escape_shifted_capslock

# `protonvpn status` takes an extra bit of time to run, so we don't want to
# update protonvpn info every second. For this reason, it is read into a
# variable which is only updated every "$imax" iterations.
imax=15
i="$imax"

while true
do
	if [ -f ~/.local/share/toggle-pvpn-status ]; then
		rm ~/.local/share/toggle-pvpn-status
		if [ "$NO_PVPN_STATUS" ]; then
			NO_PVPN_STATUS=''
			# Set i so that if VPN status info is re-enabled, we don't have to
			# wait for i to reach imax as it starts counting again to see VPN
			# status info and receive '!' notifications.
			i="$imax"
		else
			NO_PVPN_STATUS=1
		fi
	fi
	if [ "$NO_PVPN_STATUS" ]; then
		proton="<> "
	elif [ "$i" -ge "$imax" ]; then
		# We append a space here to be in between proton and keyinfo, if proton
		# isn't empty.
		proton="$(protoninfo)" && [ -n "$proton" ] && proton="$proton "
		i=0
	else
		i="$(expr "$i" + 1)"
	fi
	xsetroot -name " $proton$(keyinfo) $(vol) $(dateinfo) $(batinfo)"
	sleep 1
done &

dunst -font "monospace 11" &

exec dwm
