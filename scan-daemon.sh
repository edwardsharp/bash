#!/bin/bash

daemon() {
    sane-find-scanner
    scanimage -L
    FILES=/home/pi/scan/*.jpeg
    MV="mv"
    UPDIR="uploaded/"
    
    cd /home/pi/scan/
    if [ ! -d "$UPDIR" ]; then
      mkdir $UPDIR
    fi

    while [[ true ]]
    do
        NOW=$(date +"%s")
        sudo scanimage --format=tiff -x 215 -y 297 > $NOW.tiff
        convert -rotate "90" $NOW.tiff $NOW.jpeg
        rm $NOW.tiff
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
                sudo kill `pgrep fbi`
                sudo fbi -T 1 -a -noverbose "$UPDIR$NOW.jpeg" &
            fi
        done
        sleep 120
    done
    
}

echo "STARTING WATACH FOLDER DAEMON"
daemon

