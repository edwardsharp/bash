#!/bin/bash

#sudo chmod 777 -R /dev/bus/usb
#sudo mkdir -p /var/lock/sane

echo "about to install libusb-dev, build-essential, and libsane-dev"
read CONTINUE

apt-get install libusb-dev build-essential libsane-dev

echo "git clone git://git.debian.org/sane/sane-backends.git"
echo "./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var"
echo "copy the files backend/dll.conf and backend/genesys.conf into /etc/sane.d"