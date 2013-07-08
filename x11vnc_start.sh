#!/bin/bash

# good find via: https://gist.github.com/davejamesmiller/1965569
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
	if ask "~/.config/autostart/x11vnc.desktop?" N; then
		mkdir -p ~/.config/autostart
		touch ~/.config/autostart/x11vnc.desktop
		truncate -s0 ~/.config/autostart/x11vnc.desktop
		echo "[Desktop Entry]" >> ~/.config/autostart/x11vnc.desktop
		echo "Encoding=UTF-8" >> ~/.config/autostart/x11vnc.desktop
		echo "Type=Application" >> ~/.config/autostart/x11vnc.desktop
		echo "Name=X11VNC" >> ~/.config/autostart/x11vnc.desktop
		echo "Comment=" >> ~/.config/autostart/x11vnc.desktop
		#echo "Exec=x11vnc -forever -usepw -display :0" >> ~/.config/autostart/x11vnc.desktop
		echo "Exec=sudo x11vnc -xkb -noxrecord -noxfixes -noxdamage -display :0 -rfbauth /root/.vnc/passwd -auth /var/run/lightdm/root/:0 -shared -forever -bg -o /var/log/x11vnc.log" >> ~/.config/autostart/x11vnc.desktop
		echo "StartupNotify=false" >> ~/.config/autostart/x11vnc.desktop
		echo "Terminal=false" >> ~/.config/autostart/x11vnc.desktop
		echo "Hidden=false" >> ~/.config/autostart/x11vnc.desktop
	fi

  echo "rest needz root, use sudo!"
  exit 1 
fi

PACKAGES="x11vnc"
if ask "apt-get install $PACKAGES?" N; then
  echo "apt-get install"
	apt-get install -y $PACKAGES 
else
  echo "skipping..."
fi

## Default to No if the user presses enter without giving an answer:
if ask "write password?" N; then
	# echo "what password?"
 #  read PASS
 #   x11vnc -storepasswd PASS /etc/x11vnc/pass
 x11vnc -storepasswd
else
   echo "skipping password..."
fi

CMD="@sleep 30; sudo x11vnc -xkb -noxrecord -noxfixes -noxdamage -display :0 -rfbauth /root/.vnc/passwd -auth /var/run/lightdm/root/:0 -shared -forever -bg -o /var/log/x11vnc.log"
if ask "/etc/xdg/lxsession/LXDE/autostart?" N; then
	echo $CMD
	echo $CMD >> /etc/xdg/lxsession/LXDE/autostart	
else
   echo "skipping..."
fi


#/usr/bin/x11vnc -auth /var/run/lightdm/root/:0
#								 -auth /var/run/lightdm/root/:0

#/etc/init/x11vnc.conf

#sudo x11vnc -storepasswd Xai0Oope /etc/x11vnc/pass
#-listen localhost
#-ssl TMP
#-ssldir /etc/x11vnc/Certs -sslverify /etc/x11vnc/CA/cacert.pem
#-localhost
#-once 
# -ncache 10

if ask "start x11vnc?" N; then
	x11vnc -xkb -noxrecord -noxfixes -noxdamage -display :0 -rfbauth /root/.vnc/passwd -auth /var/run/lightdm/root/:0 -shared -forever -bg -o /var/log/x11vnc.log
else
   echo "skipping..."
fi

