#!/bin/sh
cd ~/raspy/WAP/
forever start WABot.js
cd -
while [ true ]
do
	python3 ~/raspy/bing-rewards/BingRewards/BingRewards.py | grep -E "Points earned|Streak count|Available|Lifetime" | sed -e 's/[ \t]*//' | sed 's/>//g' > ~/raspy/bing-rewards/points.txt
	rm -rf ~/raspy/bing-rewards/BingRewards/logs/*
	rm -rf ~/raspy/bing-rewards/BingRewards/src/__pycache__/*
	rm -rf ~/raspy/bing-rewards/BingRewards/__pycache__/*
	sleep 10800
done
