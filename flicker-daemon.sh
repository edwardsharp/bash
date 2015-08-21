#!/bin/bash

daemon() {
    FILES=/Users/edward/Pictures/flatbed/*.jpeg

    MV="mv"
    UPDIR="uploaded/"

    while [[ true ]]
    do
        for f in $FILES
        do
            if [[ -f "$f" ]]
            then
                echo "Processing $f file..."
                # take action on each file. $f store current file name
                #flickr_upload $f
                #rm $f
                ./flickr-up.sh -i "$f"
                mv "$f" "$UPDIR"
            fi
        done
        sleep 10
    done
}

echo "STARTING WATACH FOLDER DAEMON"
daemon
