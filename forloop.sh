#!/bin/bash

echo "This program is to print 1 to 10 numbers"

for (( i=1; i<=10; i++ ))
do
    if [ $i==10 ] then
         echo "This step is in 10th line"
    fi
done