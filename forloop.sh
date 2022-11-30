#!/bin/bash

echo "This program is to print 1 to 10 numbers"
a=10
b=20
for((i=1;i<=100;i++))
do
    if [ $a == $b ]
    then
    echo "a is equal to b"
    else
    echo "a is not equal to b"
    fi
done