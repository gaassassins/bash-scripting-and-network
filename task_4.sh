#!/bin/bash

f [ ! -f "$1" ] || [ ! -f "$2" ] || [ ! -f "$3" ]; then
  echo "Invlaid input! Files not found"
  exit 1
else
  lines_count_1=$(cat $1 | wc -l)
  lines_count_2=$(cat $2 | wc -l)

  if [ $lines_count_1 -ne $lines_count_2 ]; then
    echo "Files have a different count of lines! ($1: $lines_count_1, $2: $lines_count_2)"
    exit 1
  else
    exec > $3
    paste -d " " $1 $2
  fi
fi

