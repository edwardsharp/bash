#!/bin/bash -e

# THIS HERE SCRIPT BOOTSTRAPZ A RASPBERRY PI
# USEFUL FOR: SCAN MODE

# good find via: https://gist.github.com/davejamesmiller/1965569
## Default to No if the user presses enter without giving an answer:
#if ask "Do you want to do such-and-such?" N; then
#    echo "Yes"
#else
#    echo "No"
#fi
function ask {
    while true; do
 
        if [ "${2:-}" = "Y" ]; then
            prompt="Y/n"
            default=Y
        elif [ "${2:-}" = "N" ]; then
            prompt="y/N"
            default=N
        else
            prompt="y/n"
            default=
        fi
 
        # Ask the question
        read -p "$1 [$prompt] " REPLY
 
        # Default?
        if [ -z "$REPLY" ]; then
            REPLY=$default
        fi
 
        # Check if the reply is valid
        case "$REPLY" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac
 
    done
}

if [[ $EUID -ne 0 ]]; then
    echo "need root, use sudo!"
    exit 1
fi

echo "RASPI INIT"

if ask "raspi-config?" N; then
	raspi-config
else
    echo "skipping..."
fi



if ask "apt-get update?" N; then
    echo "apt-get update"
	
	apt-get update
else
    echo "skipping..."
fi

PACKAGES="vim unclutter x11vnc"
if ask "apt-get install $PACKAGES?" N; then
    echo "apt-get install"
	
	apt-get install -y $PACKAGES 
else
    echo "skipping..."
fi

if ask "disable blank screen?" N; then
	echo "disable screen blanking..."
	
	sed -i /$'@xscreensaver -no-splash'/d /etc/xdg/lxsession/LXDE/autostart	
	sed -i s/'BLANK_TIME='.*/'BLANK_TIME=0'/ /etc/kbd/config
	sed -i s/'POWERDOWN_TIME='.*/'POWERDOWN_TIME=0'/ /etc/kbd/config

	function add_line 
	{
		#erg!
		#sed -i /$$1/d $2
		echo $1
		sed -i s/'$1'//g $2

		#this next line should be all that is necessary	
		if grep -v -q "$1" $2; then echo $1 >> $2; fi
	} 

	AUTOSTARTFILE='/etc/xdg/lxsession/LXDE/autostart'
	STR='@xset s off'
	STR1='@xset -dpms'
	STR2='@xset s noblank'
	add_line $STR $AUTOSTARTFILE
	add_line $STR1 $AUTOSTARTFILE
	add_line $STR2 $AUTOSTARTFILE

else
    echo "skipping..."
fi

PACKAGES='sane sane-utils'
if ask "install scan utilz ($PACKAGES)?" N; then
	apt-get install -y $PACKAGES
else 
	echo "skipping..."
fi 

PACKAGES='imagemagick scanbuttond'
if ask "install ($PACKAGES)?" N; then
	apt-get install -y $PACKAGES
else 
	echo "skipping..."
fi 


PACKAGES='lockfile-progs netpbm festival toilet'
if ask "install razzle dazzle utilz ($PACKAGES)?" N; then
	apt-get install -y $PACKAGES
else 
	echo "skipping..."
fi 




