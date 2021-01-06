#!/bin/sh

keyinfo() {
	setxkbmap -query | grep -q 'variant: *intl' && echo 'INTL' || echo 'US'
}

batinfo() {
	# Print battery percentage, time remaining to full/dead, and status
	acpi 2>&1 | grep 'No support for device type' ||
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

setxkbmap -option caps:swapescape

while xsetroot -name " $(keyinfo) $(vol) $(dateinfo) $(batinfo)"
do
	sleep 1
done &

exec dwm
