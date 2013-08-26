#!/bin/bash
old_IFS=$IFS      # save the field separator           
IFS=$'\n'     # new field separator, the end of line
FILE=place.txt
while true
do
    		tput setab `gshuf -i 1-7 -n 1`;tput setaf `gshuf -i 1-7 -n 1`; toilet -tf mono9 ${ARRAY[$index]}
		sleep `gshuf -i 0-6 -n 1`
 
done
IFS=$old_IFS     # restore default field separator 
