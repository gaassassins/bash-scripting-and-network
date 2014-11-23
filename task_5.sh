#!/bin/bash

sum=0

while read line; do
for i in $line; do
if (("$i" >= "$1")) && (("$i" <= "$2"));
then
sum=$(($sum + $i))
fi
done
done

echo "Sum: "$sum
