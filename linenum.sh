#!/bin/bash
i=0
while read line
do
  i=$((i+1))
  echo $i $line
done < $1
