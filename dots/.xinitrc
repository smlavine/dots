setxkbmap -option caps:swapescape

keyinfo() {
    [ "$(setxkbmap -query | grep variant | awk '{print $2'})" = "intl" ] &&
		echo "INTL" ||
			echo "US"
}

set_batinfo() {
	# If the computer is not battery-powered, show no battery info.
	acpi 2>&1 | grep "No support for device type"
	if [ $? -eq 0 ]
	then
		batinfo=""
	else
		# Battery percentage
		batinfo=" $(acpi | awk '{print $4}' | tr -d ',')"
		# Battery time remaining
		batinfo="$batinfo $(acpi | awk '{print $5}' | sed 's/:/h/' | sed 's/:/m/' | cut -c -6)"
		# Battery status
		case "$(acpi | awk '{print $3}')" in
		Charging,)
			batinfo="$batinfo CHR"
			;;
		Discharging,)
			batinfo="$batinfo DRN"
			;;
		Full,)
			batinfo="$batinfo FULL"
			;;
		*)
			batinfo="$batinfo ?"
			;;
		esac
	fi
}

set_batinfo

while xsetroot -name " $(keyinfo) $(vol) $(date "+%a %b %d %r %Z")$batinfo"
do
    set_batinfo
	sleep 1
done &

exec dwm
