#!/bin/bash

echo "*******"

printf "%s\t%-20s\t%s\n" "USER" "COMAND" "%CPU"

echo "*******"
ps aux| awk
'{if ($3 > 0.0) 
printf "%s\t%-20s\t%.1f\n", $1, base($11), $3}

function base(pn){sub(/^.*\//, "", pn); return pn}'