#!/bin/bash

echo "This program is to print 1 to 10 numbers"
a=10
b=6
for ( i=1;i<=10;i++ )
do
    if [ $i == 8 ]
    then
    echo "a is equal to b"
    else
    echo  $i;
    fi
done