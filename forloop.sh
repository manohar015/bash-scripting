#!/bin/bash

echo "This program is to print 1 to 10 numbers"

for((i=1;i<=100;i++))
do
    if [ $i == 50 ] then
        echo "This is 50th line"
    else
         echo -n $i
    fi
done