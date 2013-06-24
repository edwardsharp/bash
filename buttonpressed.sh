#!/bin/sh

# This script is started by scanbuttond whenever a scanner button has been pressed.
# Scanbuttond passes the following parameters to us:
# $1 ... the button number
# $2 ... the scanner's SANE device name, which comes in handy if there are two or 
#        more scanners. In this case we can pass the device name to SANE programs 
#        like scanimage.

DATE=`date +"%s"`
HOME="/home/pi/scan/"
HOMEBASE="/home/pi/scan/scan$DATE"

TMPFILE="$HOMEBASE.tiff"
TMPFILE_PDF="$HOMEBASE.pdf"
TMPFILE_PS="$HOMEBASE.ps"
TMPFILE_PNM="$HOMEBASE.pnm"
TMPFILE_JPG="$HOMEBASE.jpg"
LOCKFILE="$HOME/copy.lock"

# Lock file handling and GNOME examples for buttons 2, 3, 4 below contributed
# by Lutz Müller <lutz@topfrose.de>.

if ! lockfile-create --retry 2 $LOCKFILE; then
	toilet --filter border --gay "Error: scanning already in progress for $2"  2>/dev/null 
  exit
fi
rm -f $TMPFILE
rm -f $TMPFILE_PDF
rm -f $TMPFILE_PS

case $1 in
	1)
		toilet --filter border --gay "$2 button 1 pressed"  2>/dev/null 
		
		if [ -f $LOCKFILE ]; then
		  echo "error! (another scanning operation is currently in progress?)" | festival --tts
		  exit
		fi
		touch $LOCKFILE
		rm -f $TMPFILE
		echo "body copy. body copy. body copy." | festival --tts
		# scanimage --resolution 300 --device-name $2 --mode Color -x 210 -y 297 | pnmtops -width=8.27 -height=11.69 > $TMPFILE_PS
		# ps2pdf $TMPFILE_PS $TMPFILE_PDF
		

		scanimage –resolution 100 > $TMPFILE_PNM
		convert $TMPFILE_JPG

		if [ $? != 0 ]; then
			echo "body body body scan failed. failed. failed." | festival --tts
			rm $LOCKFILE
			exit
		fi

		echo "body body body scan complete. complete. complete." | festival --tts
		rm -f $LOCKFILE

		# This example turns your scanner+printer into a photocopier.
		# Fine-tuned for the Epson Perfection 2400, the HP LaserJet 1200 and
		# ISO A4 paper size so that the scanned document matches the printer
		# output as closely as possible.
		# The festival speech synthesizer is used to inform the user about
		# the progress of the operation.
		#
		#
		# if [ -f $LOCKFILE ]; then
		#   echo "Error: Another scanning operation is currently in progress" | festival --tts
		#   exit
		# fi
		# touch $LOCKFILE
		# rm -f $TMPFILE
		# echo "Copying" | festival --tts
		# scanimage --device-name $2 --format tiff --mode Gray --quick-format A4 \
		# --resolution 300 --sharpness 0 --brightness -3 \
		# --gamma-correction "High contrast printing" > $TMPFILE
		# if [ $? != 0 ]; then
		# 	echo "Scanning failed" | festival --tts
		# 	rm $LOCKFILE
		# 	exit
		# fi
		# echo "Submitting print job" | festival --tts
		# tiff2ps -z -w 8.27 -h 11.69 $TMPFILE | lpr
		# if [ $? != 0 ]; then
		# 	echo "Printing failed" | festival --tts
		# 	rm $LOCKFILE
		# 	exit
		# fi
		# echo "The print job has been submitted" | festival --tts
		# rm -f $LOCKFILE
		#
                
                # Another example of the same action, but using other tools and
                # working with newer scanimage versions.
                # It requires sane-utils, lockfile-progs and netpbm.
                # Suggested by Francesco Potorti`.
                # 
                # if ! lockfile-create --retry 2 $LOCKFILE; then
                #   echo "Error: scanning already in progress for $2"
                #   exit
                # fi
                # SCAN_OPTIONS="--resolution 300 --contrast 10 --brightness 0"
                # scanimage --verbose --device-name $2 \
                #           --mode Gray -x 210 -y 297 $SCAN_OPTIONS |
                #   pnmtops -width=8.27 -height=11.69 |
                #   lpr -J $2 $PRINTER
                # lockfile-remove $LOCKFILE
		;;
	2)
		if toilet --filter border --gay "$2 button 2 pressed"  2>/dev/null ; then
		else
			echo "$2 button 2 pressed"
		fi
		
		# flegita
		;;
	3)
		
		if toilet --filter border --gay "$2 button 3 pressed"  2>/dev/null ; then
		else
			echo "$2 button 3 pressed"
		fi
		# scanimage --resolution 300 --device-name $2 --mode Color -x 210 -y 297 | pnmtops -width=8.27 -height=11.69 > $TMPFILE_PS
		# ps2pdf $TMPFILE_PS $TMPFILE_PDF
		# evince $TMPFILE_PDF
		;;
	4)
		if toilet --filter border --gay "$2 button 4 pressed"  2>/dev/null ; then
		else
			echo "$2 button 4 pressed"
		fi
                # scanimage --resolution 300 --device-name $2 --mode Color -x 210 -y 297 | pnmtops -width=8.27 -height=11.69 > $TMPFILE_PS
		# ps2pdf $TMPFILE_PS $TMPFILE_PDF
                # nautilus-sendto $TMPFILE_PDF
		;;
esac

lockfile-remove $LOCKFILE
