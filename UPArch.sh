#!/bin/sh

archVerRemote=$(curl -s https://archlinux.org/download/ | grep -i "torrent for" | sed -e 's/<[^>]*>//g' | cut -d ">" -f2 | cut -d " " -f3)
archVer=$(echo $(ls *.iso || echo "notinstalled") | cut -d "-" -f2)
if [ "$archVerRemote" != "$archVer" ]
then
	cd ~/.config/raspy
	mkdir -p ~/.config/raspy/ISOS
	curl -s https://wiki.archlinux.org/title/Installation_guide > archInstallGuide.txt
	cat archInstallGuide.txt | tail -$(expr $(cat archInstallGuide.txt | grep -in '</html>' | cut -f1 -d ":") - $(cat archInstallGuide.txt | grep -in "Installation guide" | tail -1 | cut -f1 -d ":")) | sed 's/<\/*[^>]*>//g' > archInstallGuide.txt

	if pgrep -x "transmission-cl" > /dev/null
	then
		killall -9 transmission-cli
	fi

	if [ -f *.part ]
	then
		rm -rf *.part ~/.config/transmission
		transmission-cli -D ~/.config/raspy/archISO.torrent -f ~/.config/raspy/UPArch.sh -w ~/.config/raspy
		exit
	fi

	if [ -f *.iso ]
	then
		archVerRemote=$(curl -s https://archlinux.org/download/ | grep -i "torrent for" | sed -e 's/<[^>]*>//g' | cut -d ">" -f2 | cut -d " " -f3)
		archVer=$(ls *.iso | cut -d "-" -f2)
		if [ "$archVerRemote" != "$archVer" ]
		then
			mv *.iso ~/.config/raspy/ISOS
			~/.config/raspy/UPArch.sh & exit
		fi
	else
		curl "https://archlinux.org/download/" > ~/.config/raspy/archlinuxDownloadSite.html
	
		curl "https://archlinux.org$(cat archlinuxDownloadSite.html | grep -i "<a href="  | grep -i "torrent" | cut -d "\"" -f2)" -o archISO.torrent
	
		rm -rf ~/.config/transmission
		transmission-cli -D ~/.config/raspy/archISO.torrent -f ~/.config/raspy/UPArch.sh -w ~/.config/raspy 
		exit
	fi
	
	md5arch=$(md5sum *.iso | awk '{ print $1 }')
	md5archRemote=$(curl -s "https://archlinux.org/download/" | grep -i "md5" | tail -1 | sed -e 's/<[^>]*>//g' | cut -d ":" -f2 | cut -d " " -f2)
	if [ "$md5arch" != "$md5archRemote" ]
	then
		~/.config/raspy/UPArch.sh & exit
	
	fi
	echo "END"
else
	echo "no update"
fi
