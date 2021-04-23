#!/bin/sh

protoninfo() {
	status="$(protonvpn status)"
	# If there is an error connecting to the VPN, then display '! !'; otherwise
	# display the VPN information as normal.
	echo "$status" | grep -o '!' ||
		echo "$status" | grep -E 'Server|Load' | awk '{print $2}' | paste - - |
		tr '\t' ':'
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

# The counter for reading protonvpn info. See the comment below.
imax=15
i="$imax"

while true
do
	# protonvpn status takes an extra little bit of time to run, so we don't
	# want to update protonvpn info every second. For this reason, it is read
	# into a variable which is only updated every "$imax" iterations.
	if [ "$i" -ge "$imax" ]; then
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

exec dwm
