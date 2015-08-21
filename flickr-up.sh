#!/bin/bash

OPTIONS='t:d:a:p:f:m:s:c:h:i:'
APIKEY='zzz'
SECRET='666'
DOTFILE="$HOME/.flickr-shell-uploader"
FROB=''
TOKEN=''
ALIASES=''
OLDALIASES=''
ALIASIDX=0

# Check we have some command line arguments at least
if [ $# -eq 0 ]; then
    cat <<EOF
Usage:
    flickr-shell-uploader [-t TITLE] [-d DESCRIPTION] [-a TAGS] [-p IS_PUBLIC] [-f IS_FRIEND] [-m IS_FAMILY] [-s SAFETY_LEVEL] [-c CONTENT_TYPE] [-h HIDDEN] -i <file> [-i <file> ...]
    All of the below options are optional (aside from files to upload):
    TITLE: Title of your photo.
    DESCRIPTION: Description of your photo.
    TAGS: Comma-separated list of tags for the photo (no spaces).
    IS_PUBLIC: 0 = no, 1 = yes - viewable by anyone.
    IS_FRIEND: 0 = no, 1 = yes - friends can view the photo.
    IS_FAMILY: 0 = no, 1 = yes - family can view the photo.
    SAFETY_LEVEL: 1 = safe, 2 = moderate, 3 = restricted.
    CONTENT_TYPE: 1 = photo, 2 = screenshot, 3 = other.
    HIDDEN: 1 = visible, 2 = hidden. Hides the photo from public searches.
    One or more files may be supplied, but the above options may only be useful for individual files!
EOF
    exit 0
fi

# Parse command line options
FILEINDEX=0
while getopts $OPTIONS name; do
    case $name in
        t)
            title="$OPTARG"
            ;;
        d)
            description="$OPTARG"
            ;;
        a)
            tags="${OPTARG/,/ }"
            ;;
        p)
            is_public="$OPTARG"
            ;;
        f)
            is_friend="$OPTARG"
            ;;
        m)
            is_family="$OPTARG"
            ;;
        s)
            safety_level="$OPTARG"
            ;;
        c)
            content_type="$OPTARG"
            ;;
        h)
            hidden="$OPTARG"
            ;;
        i)
            FILES[$FILEINDEX]="$OPTARG"
            let FILEINDEX=FILEINDEX+1
            ;;
    esac
done

require() {
    local program=$1
    local alternative=$2

    if ! which $program > /dev/null && [ "x" == "x${alternative}" ]; then
        echo "Unable to find ${program} (not installed or in PATH), which is required."
        exit 1
    elif ! which $program > /dev/null && ! which $alternative > /dev/null; then
        echo "Unable to find ${program} or alternative ${alternative} (not installed or in PATH), at least one of which is required."
        exit 1
    elif ! which $program > /dev/null; then
        program=$alternative
    fi

    # Set an alias to the command if it exists, so we don't use a shell built-in.
    # Also preserve any old aliases.
    if alias $program >/dev/null 2>&1; then
        OLDALIASES[$ALIASIDX]="$(alias $program)"
    else
        OLDALIASES[$ALIASIDX]=''
    fi
    ALIASES[$ALIASIDX]=$program
    let ALIASIDX=ALIASIDX+1
    alias $program=$(which $program)
}

# Reset aliases back to original values or unalias, if applicable.
removealiases() {
    i=0
    while [ $i -lt $ALIASIDX ]; do
        unalias ${ALIASES[$i]}
        if ! [ "x" == "x${OLDALIASES[$i]}" ]; then
            eval "${OLDALIASES[$i]}"
        fi
        let i=i+1
    done
}        

loadconfig() {
    [ -f "$DOTFILE" ] && source "$DOTFILE"
}

getfrob() {
    if [ "x$FROB" == "x" ]; then
        local SIG=$(printf %b ${SECRET}api_key${APIKEY}methodflickr.auth.getFrob | md5 | awk '{print $1}')
        FROBINFO=$(curl -s "https://api.flickr.com/services/rest/?method=flickr.auth.getFrob&api_key=${APIKEY}&api_sig=${SIG}")
        local RC=$?
        if [ $RC -ne 0 ]; then
            echo "curl returned error $RC. Please consult the curl documentation for the error meaning."
            exit $RC
        fi
        if echo $FROBINFO | grep -qi "err"; then
            echo "The Flickr API returned an error while retrieving the frob. Please try again."
            exit 2
        fi
        FROB=$(echo $FROBINFO | grep -o '<frob>.*</frob>' | tr '<>' ' ' | awk '{print $2}')
        echo "FROB=$FROB" > "$DOTFILE"
    fi
}

auth() {
    if [ "x$TOKEN" == "x" ]; then
        local SIG=$(printf %b ${SECRET}api_key${APIKEY}frob${FROB}permswrite | md5 | awk '{print $1}')
        echo "Please go to the following URL: https://flickr.com/services/auth/?api_key=${APIKEY}&perms=write&frob=${FROB}&api_sig=${SIG}"
        echo ""
        echo "Then return here and press enter."
        read line
    fi
}

gettoken() {
    if [ "x$TOKEN" == "x" ]; then
        local SIG=$(printf %b ${SECRET}api_key${APIKEY}frob${FROB}methodflickr.auth.getToken | md5 | awk '{print $1}')
        TOKENINFO=$(curl -s "https://api.flickr.com/services/rest/?method=flickr.auth.getToken&api_key=${APIKEY}&frob=${FROB}&api_sig=${SIG}")
        local RC=$?
        if [ $RC -ne 0 ] || echo $TOKENINFO | grep -qi "err"; then
            echo "Was not able to successfully get the token of the confirmed frob. Try deleting $DOTFILE and starting again."
            exit 3
        fi
        TOKEN=$(echo $TOKENINFO | grep -o '<token>.*</token>' | tr '<>' ' ' | awk '{print $2}')
        echo "TOKEN=$TOKEN" >> "$DOTFILE"
    fi
}

checktoken() {
    if [ "x$TOKEN" == "x" ]; then
        echo "No token was defined."
        exit 4
    else
        local SIG=$(printf %b ${SECRET}api_key${APIKEY}auth_token${TOKEN}methodflickr.auth.checkToken | md5 | awk '{print $1}')
        TOKENINFO=$(curl -s "https://api.flickr.com/services/rest/?method=flickr.auth.checkToken&api_key=${APIKEY}&auth_token=${TOKEN}&api_sig=${SIG}")
        local RC=$?
        if [ $RC -ne 0 ] || echo $TOKENINFO | grep -qi "err"; then
            echo "Was not able to successfully check the token of the confirmed frob. Try deleting $DOTFILE and starting again."
            exit 5
        fi
        if ! echo $TOKENINFO | grep -q '<perms>write</perms>'; then
            echo "Don't have write permissions. Try deleting $DOTFILE and starting again."
            exit 6
        fi
    fi
}

upload() {
    FILE="${FILES[$1]}"
    if ! [ -f "$FILE" ]; then
        echo "$FILE does not exist"
        return
    fi

    # Make a temp file to hold the commands for uploading, with correct quoting.
    # Bash tends to make a mess of things with all the variable interpolation
    # going on here.
    TMPFILE="/tmp/flickr-shell-uploader.$$"
    printf %b "UPLOAD=\$(curl -s -F api_key=${APIKEY} -F auth_token=${TOKEN}" > $TMPFILE

    # Construct signature text and query
    local SIGTEXT="${SECRET}api_key${APIKEY}auth_token${TOKEN}"
    IFS=$(printf "\n\b")
    for i in content_type description hidden is_family is_friend is_public safety_level tags title; do
        if [ "x" != "x$(eval printf %b \$$i)" ]; then
            SIGTEXT="${SIGTEXT}${i}$(eval printf %b \$$i)"
            printf %b " -F ${i}=\"$(eval printf %b \$$i)\"" >> $TMPFILE
        fi
    done

    local SIG=$(printf %b $SIGTEXT | md5 | awk '{print $1}')
    printf %b " -F api_sig=${SIG} -F photo=@\"${FILE}\" https://api.flickr.com/services/upload/)" >> $TMPFILE
    echo -e "\nRC=\$?" >> $TMPFILE
    source $TMPFILE
    if [ $RC -ne 0 ] || echo $UPLOAD | grep -qi 'err'; then
        echo "Error uploading file $FILE"
    else
        printf %b "Uploaded $FILE"
        echo $UPLOAD | grep -o 'photoid>[[:digit:]]*<' | tr '<>' ' ' | awk '{ print " with photoid", $2 }'
    fi
    rm -f $TMPFILE
}

# We need these tools to run
require curl
require awk
require grep
require tr
# "md5" is found on OSX instead of md5, so provide that as an alternative.
require md5 md5

# Load a previously saved frob, otherwise make a new one
loadconfig
getfrob

# Authenticate, and check the resulting token
auth
gettoken
checktoken

# Upload the actual files!
x=0
while [ $x -lt $FILEINDEX ]; do
    # Let the uploader just grab the filename variable itself from the array
    upload $x
    let x=x+1
done
removealiases