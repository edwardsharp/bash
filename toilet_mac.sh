#!/bin/bash
old_IFS=$IFS      # save the field separator           
IFS=$'\n'     # new field separator, the end of line
FILE=place.txt
while true
do
	while read LINE; do
		if [ $(($RANDOM % 6)) = 0 ]
			then 
			clear
			while [ $(($RANDOM % 6)) = 0 ]
			do
				tput setab `gshuf -i 1-7 -n 1`;tput setaf `gshuf -i 1-7 -n 1`; toilet -tf mono9 "|"
				sleep 0.2
			done
		fi
		if [ $(($RANDOM % 2)) = 0 ]
			then toilet -tf mono9 --gay "$LINE"
			sleep `gshuf -i 3-9 -n 1`
		fi	
		if [ $(($RANDOM % 2)) = 0 ]
			then tput setab `gshuf -i 1-7 -n 1`;tput setaf `gshuf -i 1-7 -n 1`; toilet -tf mono9 "$LINE"
			sleep `gshuf -i 3-9 -n 1`
		fi
		if [ $(($RANDOM % 2)) = 0 ]
                        then tput blink; toilet -tf mono9 --gay "$LINE"
                        sleep `gshuf -i 3-9 -n 1`
                fi
		tput setaf `gshuf -i 1-7 -n 1`; toilet -tf mono9 "$LINE" 
	    	sleep `gshuf -i 1-10 -n 1`
	done < "$FILE"
done
IFS=$old_IFS     # restore default field separator
