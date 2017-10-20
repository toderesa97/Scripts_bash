#!/bin/bash

# 0 is considered as even
if [ $# -le 0 ]; then
	echo "No arguments found"
	exit 1
fi
even=0
# If -odd found, show odd lines, -even for even lines. The default is odd
if [ $1 == "-even" ]; then
	even=1
	shift
fi
if [ $1 == "-odd" ]; then
	shift
fi
p="p"
# showing multiple files. $# variable decreases when shift is used
while [ $# -ge 1 ]
do
	echo "*********** Printing $1 lines ***********"	
	length=$(wc -l $1 | cut -f1 -d' ')
	for i in `seq 1 $length`;
	do
		if [ $(($i % 2)) == 0 ] && [ $even == 1 ]; then
			echo $(sed -n $i,$i$p $1)		
		fi
		if [ $(($i % 2)) != 0 ] && [ $even == 0 ]; then
			echo $(sed -n $i,$i$p $1)		
		fi
	done
	shift
done
