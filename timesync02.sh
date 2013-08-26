#!/bin/bash

STARTDATE=$(date +%M)
ONCE=false

FILE=timesync.txt
unset lines n
while IFS= read -r 'lines[n++]'; do :; done < "$FILE" 

function fade {

	for i in {235..255}; do 
		tput setab $i; tput setaf $i; toilet -tf mono9 "██▐▐██▐▐██▐▐██▐▐██▐▐██▐▐██▐▐██▐▐██▐▐██▐▐██▐▐██▐▐██▐▐██▐▐██▐▐██▐▐██▐▐██▐▐██▐▐██▐▐██▐▐██▐▐██▐▐██▐▐██▐▐██▐▐██▐▐██▐▐██▐▐██▐▐██▐▐██"
		sleep 1
	done
	for i in {235..255}; do 
		tput setab $i; tput setaf $i; toilet -tf mono9 "▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄"
		sleep 1
	done
	for i in {235..255}; do 
		tput setab $i; tput setaf $i; toilet -tf mono9 "▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐█▐█▐▐▐▐▐▐▐▐▐▐▐▐▐▐█▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐█▐█▐▐▐▐▐▐▐▐▐▐▐▐▐▐█▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐█▐█▐▐▐▐▐"
		sleep 1
	done
}

function out {
	for i in {15..29}; do
		tput setab 201; tput setaf `shuf -i 1-7 -n 1`; toilet -tf mono9 "${lines[$i]}"
		sleep 4
	done
}

function violet {

	for i in {235..255}; do 
		tput setab 200; tput setaf $i; toilet -tf mono9 "░░░░░░░░░░░  ░░░░░░░░░░  ░░░░░░░░░     ░░░░    ░░░░░    ░░░░░░░ ░░░░░░          ░░░░░░░░ ░░░░░░░       ░░░░░░░░ ░░░░░░ ░░░░░░░"
		sleep 1
	done
	for i in {235..255}; do 
		tput setab 201; tput setaf $i; toilet -tf mono9 "▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄"
		sleep 1
	done
	for i in {235..255}; do 
		tput setab $i; tput setaf 21; toilet -tf mono9 "╋╋╋    ╋╋╋╋╋╋╋╋╋╋╋╋        ╋╋╋╋╋╋╋╋    ╋╋╋╋╋╋╋   ╋╋        ╋╋                      ╋╋     ╋╋ ╋    ╋"
		sleep 1
	done
}

function red {
	for i in {205..225}; do 
		tput setab 9; tput setaf $i; toilet -tf mono9 "╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲    ╲╲╲╲╲╲╲╲╲╲╲     ╲╲╲╲╲╲╲╲╲╲╲╲╲╲╲    ╲╲╲╲╲╲ ╲╲╲╲╲   ╲╲╲╲╲╲     ╲╲╲╲╲╲    ╲╲╲╲   ╲╲╲╲  ╲╲       ╲╲╲╲╲╲╲╲"
		sleep 1
	done
	for i in {205..225}; do 
		tput setab 131; tput setaf $i; toilet -tf mono9 "▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄"
		sleep 1
	done
	for i in {205..225}; do 
		tput setab 199; tput setaf $i; toilet -tf mono9 "╳ ╳ ╳ ╳ ╳ ╳  ╳ ╳ ╳ ╳ ╳ ╳     ╳ ╳ ╳ ╳ ╳ ╳ ╳ ╳ ╳ ╳     ╳ ╳ ╳       ╳ ╳        ╳ ╳       ╳ ╳  ╳           ╳ ╳     ╳    ╳   ╳   ╳ "
		sleep 1
	done
	#╲¬
}

function blue {
	for i in {105..125}; do 
		tput setab 5; tput setaf $i; toilet -tf mono9 "╲╲      ╲╲     ╲   ╲╲╲╲╲╲                    ╲╲╲╲╲    ╲╲╲╲ ╲╲╲╲╲╲╲╲    ╲╲╲╲ ╲╲╲╲╲╲╲╲╲╲╲╲"
		sleep 1
	done
	for i in {35..55}; do 
		tput setab 201; tput setaf $i; toilet -tf mono9 "                                                                                       "
		sleep 1
	done
	for i in {5..25}; do 
		tput setab 200; tput setaf $i; toilet -tf mono9 "╳   ╳        ╳             ╳                         ╳   ╳    ╳ ╳        ╳   ╳   ╳   ╳ "
		sleep 1
	done
	#╲¬
}

while true; do
	#wait until the minute is round
	# if [ $(date +%M) -gt $STARTDATE ]; then 
		DATE=$( echo $(date +%M) | sed 's/^0*//' )

		if (( 0 <= $DATE && $DATE <= 1 )); then 
			fade
		fi
		if (( 2 <= $DATE && $DATE <= 3 )); then 
			fade
		fi
		if (( 4 <= $DATE && $DATE <= 5 )); then 
			fade
		fi
		if (( 6 <= $DATE && $DATE <= 7 )); then 
			violet
		fi
		if (( 8 <= $DATE && $DATE <= 9 )); then 
			out
		fi
		if (( 10 <= $DATE && $DATE <= 11 )); then 
			blue
		fi
		if (( 12 <= $DATE && $DATE <= 13 )); then 
			violet
		fi
		if (( 14 <= $DATE && $DATE <= 15 )); then 
			out
		fi
		if (( 16 <= $DATE && $DATE <= 17 )); then 
			out
		fi
		if (( 18 <= $DATE && $DATE <= 19 )); then 
			violet
		fi
		if (( 20 <= $DATE && $DATE <= 21 )); then 
			out
		fi
		if (( 22 <= $DATE && $DATE <= 23 )); then 
			blue
		fi
		if (( 24 <= $DATE && $DATE <= 25 )); then 
			violet
		fi
		if (( 26 <= $DATE && $DATE <= 27 )); then 
			out
		fi
		if (( 28 <= $DATE && $DATE <= 29 )); then 
			out
		fi
		if (( 30 <= $DATE && $DATE <= 31 )); then 
			out
		fi
		if (( 32 <= $DATE && $DATE <= 33 )); then 
			out
		fi
		if (( 34 <= $DATE && $DATE <= 35 )); then 
			out
		fi
		if (( 36 <= $DATE && $DATE <= 37 )); then 
			violet
		fi
		if (( 38 <= $DATE && $DATE <= 39 )); then 
			red
		fi
		if (( 40 <= $DATE && $DATE <= 41 )); then 
			fade
		fi
		if (( 42 <= $DATE && $DATE <= 43 )); then 
			fade
		fi
		if (( 44 <= $DATE && $DATE <= 45 )); then 
			fade
		fi
		if (( 46 <= $DATE && $DATE <= 47 )); then 
			fade
		fi
		if (( 48 <= $DATE && $DATE <= 49 )); then 
			fade
		fi
		if (( 50 <= $DATE && $DATE <= 51 )); then 
			fade
		fi
		if (( 52 <= $DATE && $DATE <= 53 )); then 
			fade
		fi
		if (( 54 <= $DATE && $DATE <= 55 )); then 
			fade
		fi
		if (( 56 <= $DATE && $DATE <= 57 )); then 
			fade
		fi
		if (( 58 <= $DATE && $DATE <= 60 )); then 
			fade
		fi
		
		# if (( 0 <= $(date +%M) && $(date +%M) <= 0 )); then 
		#fi

	#echo -en "equal" ; 
	# else 
	# 	echo -en "WAIT"
	# 	sleep 0.1
	# fi
done
