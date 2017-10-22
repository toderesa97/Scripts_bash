#!/bin/bash

if [ -f files_cpp ]; then
	rm files_cpp
fi

if [ $# -le 0 ]; then
	find ./ -iname "*.cpp" > files_cpp
	directory="./"
else
	find $1 -iname "*.cpp" > files_cpp
	directory="$1"
fi

p="p"
lines=$(wc -l files_cpp | cut -f1 -d' ')
for i in `seq 1 $lines`; do
	sed -n $i,$i$p files_cpp > tmp
	line=$(sed -n $i,$i$p files_cpp)
	cut -f3 -d'/' tmp > tmp1
	file_name=$(cut -f1 -d. tmp1)
	sed -n $i,$i$p files_cpp > tmp
	route_until=$(grep -o "/" tmp | wc -l)
	route=$(cut -f1-$route_until -d/ tmp)
	echo "file_name = $file_name"
	echo "route--> $route"
	echo "mv $line $route/$file_name.cp"
done
# rm files_cpp


