#!/bin/bash

daemon() {
    chsum1=""

    while [[ true ]]
    do
        chsum2=`find . -type f -exec md5 {} \;`
        if [[ $chsum1 != $chsum2 ]] ; then  
			file="`ls -t | head -1`"         
            if [[ $file == *.jpeg ]]; then
			    echo "`ls -t | head -1`"
				open "`ls -t | head -1`"
			fi
            chsum1=`find . -type f -exec md5 {} \;`
        fi
        sleep 2
    done
}

echo "STARTING WATACH FOLDER DAEMON"
daemon
