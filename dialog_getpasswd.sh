#!/bin/bash
# getpasswd2.sh - A sample shell script to read users password.
# password storage
data=$(tempfile 2>/dev/null)
 
# trap it
trap "rm -f $data" 0 1 2 5 15
 
# get password with the --insecure option
dialog --title "Password" \
--clear \
--insecure \
--passwordbox "Enter your password" 10 30 2> $data
 
ret=$?
 
# make decison
case $ret in
  0)
    echo "Password is $(cat $data)";;
  1)
    echo "Cancel pressed.";;
  255)
    [ -s $data ] &&  cat $data || echo "ESC pressed.";;
esac
