#!/bin/bash

filename=$(basename "$1")
extension="${filename##*.}"
filename="${filename%.*}"

for var in {1..9}; do
cp $1 $filename"-0"$var"."$extension
done

cp $1 $filename"-10."$extension
