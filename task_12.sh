#!/bin/bash

function iP {
    i=2
    while (( i * i <= $1 )); do
        if (( $1 % $i == 0 )); then
            return 1
        fi
    (( i += 1))
    done

return 0
            }

function prim {
    typeset a i=2 j m=$1
    while (( i <= m )); do
        a[$i]=$i
        (( i++ ))
    done

i=2
while (( j = i * i, j <= m )); do
    if [[ -n ${a[$i]} ]]; then
        while (( j <= m )); do
            unset a[$j]
            (( j += i ))
        done
    fi
    (( i++ ))
done

echo ${a[*]}
            }

prim $1

if $(iP $1); then
    echo "YES"
        else
    echo "NO"
fi