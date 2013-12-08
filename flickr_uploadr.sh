#!/bin/bash

daemon() {
    FILES=/home/pi/*.jpeg

    while [[ true ]]
    do
        for f in $FILES
        do
            if [[ ! -f "$f" ]]
            then
                echo "Processing $f file..."
                # take action on each file. $f store current file name
                #flickr_upload $f
                #rm $f
            fi
        done
        sleep 10
    done
}

echo "STARTING WATACH FOLDER DAEMON"
daemon
