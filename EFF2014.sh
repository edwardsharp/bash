#!/bin/bash

#read argument filename and split by word FOUR TIMEZ!
# then interlace the output

for word1 in `cat $1 | tr ' ' '\n'`; do
        word_array1[$counter1]=$word1
        counter1=$counter1+1
done


if [ ! -z "$2" ]; then
	for word2 in `cat $2 | tr ' ' '\n'`; do
	        word_array2[$counter2]=$word2
	        counter2=$counter2+1
	done
fi

if [ ! -z "$3" ]; then
	for word3 in `cat $3 | tr ' ' '\n'`; do
	        word_array3[$counter3]=$word3
	        counter3=$counter3+1
	done
fi 

if [ ! -z "$4" ]; then
	for word4 in `cat $4 | tr ' ' '\n'`; do
	        word_array4[$counter4]=$word4
	        counter4=$counter4+1
	done
fi 

arr=( ${#word_array1[@]} ${#word_array2[@]} ${#word_array3[@]} ${#word_array4[@]} )

min=0 max=0

for i in ${arr[@]}; do
    (( $i > max || max == 0)) && max=$i
    (( $i < min || min == 0)) && min=$i
done

echo "MIN=$min MAX=$max"

#interlace the text for, stop when the shortest text runs out
for index in $(seq $min $END) 
do 
	#echo "${word_array1[index]}   ${word_array2[index]}    ${word_array3[index]}    ${word_array4[index]}" 
	printf "%-20s %-20s% -20s% -20s" ${word_array1[index]} ${word_array2[index]} ${word_array3[index]} ${word_array4[index]}
	echo ""
	echo ""
done

