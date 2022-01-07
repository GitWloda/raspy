#!/bin/sh
archVer=$(curl -s https://archlinux.org/download/ | grep -i "torrent for" | sed -e 's/<[^>]*>//g' | cut -d ">" -f2 | cut -d " " -f3)
if pgrep -x "transmission-cl" > /dev/null
then
	killall -9 transmission-cli
fi

if [ -f *.part ]
then
	rm -rf *.part ~/.config/transmission
	transmission-cli -D archISO.torrent -f ~/Downloads/raspy.sh
fi

if [ ! -f *.iso ]
then
	curl "https://archlinux.org/download/" > archlinuxDownloadSite.html

	curl "https://archlinux.org$(cat archlinuxDownloadSite.html | grep -i "<a href="  | grep -i "torrent" | cut -d "\"" -f2)" -o archISO.torrent

	rm -rf *.part ~/.config/transmission
	transmission-cli -D archISO.torrent -f ~/Downloads/raspy.sh
fi

md5arch=$(md5sum archlinux-2022.01.01-x86_64.iso | awk '{ print $1 }')
md5archRemote=$(curl -s "https://archlinux.org/download/" | grep -i "md5" | tail -1 | sed -e 's/<[^>]*>//g' | cut -d ":" -f2 | cut -d " " -f2)
if [ $md5arch != $md5archRemote ]
then
	~/Downloads/raspy.sh
fi
echo "finito"
