#!/bin/bash

IFS=$'\n'
DIR=""

if [ "$#" -eq 1 ]; then
	if [ -d "$1" ]; then
		DIR="$1/"
	else
		exec echo "error"
	fi
fi

for file in $(ls $DIR)
do
	extension=".${file##*.}"
	if [[ "$extension" == ".lnk" ]]; then
		if [ ! -e "$file" ] ; then
			rm ${DIR}${file}	
		else
			fileconten=$(cat ${DIR}${file})
			size=${#fileconten} 
			if [ $size -eq 0 ]; then
				echo "${DIR}${file} is empty"
			fi
		fi
	fi
done