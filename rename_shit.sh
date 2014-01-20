#!/bin/bash

#FILEZ
find . -depth -name "*from_stuff*" -execdir sh -c 'mv {} $(echo {} | sed "s/from_stuff/to_stuff/")' \;

#FILE CONTENTZ
find . -name '*' | xargs perl -pi -e 's/from_stuff/to_stuff/g'
