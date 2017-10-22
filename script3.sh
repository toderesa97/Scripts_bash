#!/bin/bash

if [ $# -le 0 ]; then
	echo "Fatal: required argument"
	exit 1
fi

p="p"
# obtaining the system's users
users=$(wc -l /etc/passwd | cut -f1 -d' ')

for i in `seq 1 $users`; do
	user=$(sed -n $i,$i$p /etc/passwd | cut -f1 -d:)
	n_files=$(find / -user "$user" > tmp 2>&1)
	n_files=$(wc -l tmp | cut -f1 -d' ')
	if [ $n_files -ge $1 ]; then
		echo $user
	fi
	rm tmp
done
