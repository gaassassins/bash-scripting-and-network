#!/bin/bash

DIR=""

if [ "$#" -eq 1 ]; then
	mkdir $1
	DIR="$1/"
fi

touch "${DIR}original.file"
ln -s "${DIR}original.file" "${DIR}original.lnk"
# rm "${DIR}original.file"

for i in {1..10}
do
    filename="${DIR}ver$i.file"
    touch $filename
    ln -s $filename "${DIR}ver$i.lnk"
    rm $filename
done