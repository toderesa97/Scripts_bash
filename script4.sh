#!/bin/bash

if [ -f files_cpp ]; then
	rm files_cpp
fi
if [ -f tmp ]; then
	rm tmp
fi
if [ -f tmp1 ]; then
	rm tmp1
fi

# searching files which meet the condition
if [ $# -le 0 ]; then
	find ./ -iname "*.cpp" > files_cpp
else
	find $1 -iname "*.cpp" > files_cpp
fi

p="p"
lines=$(wc -l files_cpp | cut -f1 -d' ') 
for i in `seq 1 $lines`; do
	sed -n $i,$i$p files_cpp > tmp   	
	line=$(sed -n $i,$i$p files_cpp)
	route_until=$(($(grep -o "/" tmp | wc -l)+1))
	cut -f$route_until- -d'/' tmp > tmp1
	file_name=$(cut -f1 -d. tmp1)
	sed -n $i,$i$p files_cpp > tmp
	route_until=$(grep -o "/" tmp | wc -l)
	route=$(cut -f1-$route_until -d/ tmp)
	mv $line $route/$file_name.cp
done
# dropping safely created files
if [ -f files_cpp ]; then
	rm files_cpp
fi
if [ -f tmp ]; then
	rm tmp
fi
if [ -f tmp1 ]; then
	rm tmp1
fi


