#!/bin/bash

if [ $# -le 0 ]; then
	min=$(grep -E "UID_MIN" /etc/login.defs | sed -n 1,1p | tr -s ' ' | cut -f2 -d' ')
	max=$(grep -E "UID_MAX" /etc/login.defs | sed -n 1,1p | tr -s ' ' | cut -f2 -d' ')
else
	if [ $# -le 1 ]; then
		echo "Fatal error: Expected 2 arguments"
		exit 1
	else	
		min=$1
		max=$2
		if [ $min -gt $max ]; then
			echo "Fatal error: first param must be lower than second"
			exit 1
		fi
	fi
fi
p="p"
# Finding all users whose UID are within the given range
lines=$(wc -l /etc/passwd | cut -f1 -d' ')
for i in `seq 1 $lines`;
do
	user=$(sed -n $i,$i$p /etc/passwd | cut -f1 -d:)
	uid=$(sed -n $i,$i$p /etc/passwd | cut -f3 -d:)
	if [ $uid -ge $min ] && [ $uid -le $max ]; then
		echo $user
	fi
done
