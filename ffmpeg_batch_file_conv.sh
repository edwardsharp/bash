#!/bin/bash

echo -n "what extension to search for? "
read sext

echo -n "what extension to render? "
read rext

for i in *.$sext;
	do name=`echo $i | cut -d'.' -f1`;
	echo $name;
	ffmpeg -i $i -an $name.$rext;
done
