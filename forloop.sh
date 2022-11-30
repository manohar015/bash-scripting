#!/bin/bash

echo "This program is to print 1 to 10 numbers"
a=10
b=20
for (( i=1; i<=10; i++ ))
do
    if [ $i == 10 ] then
    echo "This step is in 10th line"
    fi

    if [ $a == $b ]
    then
    echo "a is equal to b"
    fi
done