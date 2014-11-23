#!/bin/bash

as=1
cr=1

while (($cr <= $n)); do
  as=$(($as * $cr))
  cr=$(($cr + 1))
done

echo "$n! = $as"
