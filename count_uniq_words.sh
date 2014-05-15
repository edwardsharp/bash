#!/bin/bash

deffile=wordcount.txt

THEFILE=${1:-$deffile}  

#sed -e 's/\s/\n/g' < $THEFILE | sort | uniq -c | sort -nr | head  -10
tr -c '[:alnum:]' '[\n*]' < $THEFILE | sort | uniq -c | sort -nr | head  -50