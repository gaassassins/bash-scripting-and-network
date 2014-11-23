#!/bin/bash

export filename="./[a-zA-Z]*"
export txtpat="[a-zA-Z]"

path=""
while read line; do
path="${ppath} ${line}* "
done < ${dir_lst_file}

find . -type f -regex ${filename} | xargs grep -R ${txtpat} ${path}