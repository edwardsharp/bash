#!/bin/bash
old_IFS=$IFS      # save the field separator           
IFS=$'\n'     # new field separator, the end of line
FILE=place.txt
while true
do
	ARRAY=( ▐▐██▐▐▐██▐▐▐▐▐▄ ▐▐██▐▐▐██▐▐▐██▐▐▐▐██▐ █▐▐▐█▐ ▐▐██▐▐▐██▐▐▐██▐▐ ▐▐▐██▐▐▐██▐▐▐██▐▐▐██▐ ▐▐██▐▐▐██▐▐▐██▐▐▐██▐▐ ▐ ▐▐██▐▐▐██▐▐▐██▐▙ ▝ ▐▐██▐▐▐██▐▐▐██▐▐▐▐▐▐▐▐▙  ▄ ▐▐██▐▐▐██▐▐▐██▐▐▐██▐▐▐██▐▐▐██▐▖▐▐▐▐██▐▐▐██▐▐▐██▐ ▌ ▐▐▐██▐▐▐██▐▐▐██▐▐▐██▐▐██▐▙ ▐▐██▐▐▐██▐▐▐██▐▐▐██▐▐▐██▐▐▐██▐▐▐██▐ ▐▐██▐▐▐██▐▐▐██▐▐▐██▐▐▐██▐ ▐▐██▐▐▐██▐▐▐██▐▐▐██▐▐▐██▐▐▐██▐ ▐▐██▐ ▐▐██▐▐▐██▐▐▐██▐▐▐██▐▐▐██▐▐▐██▐▐▐▐██▐▐██▐ ▐▐██▐▐▐▐▐██▐▐▐██▐▐▐██▐█▐▐██▐█▐▐██▐▐)
	for index in `shuf --input-range=0-$(( ${#ARRAY[*]} - 1 )) | head -${N}`
	do
    		tput setab `shuf -i 1-7 -n 1`;tput setaf `shuf -i 1-7 -n 1`; toilet -tf mono9 ${ARRAY[$index]}
		sleep `shuf -i 0-6 -n 1`
	done
 
done
IFS=$old_IFS     # restore default field separator 
