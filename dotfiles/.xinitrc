setxkbmap -option caps:swapescape

get_key() {
    if [ "$(setxkbmap -query | grep variant | awk '{print $2'})" = "intl" ]
    then
        key="INTL"
    else
        key="US"
    fi

}

get_key

while xsetroot -name " $key $(vol) $(date "+%a %b %d %r %Z %Y")"
do
    get_key
	sleep 1
done &

exec dwm
