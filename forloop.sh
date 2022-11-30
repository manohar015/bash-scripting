#!/bin/bash

echo "This program is to print 1 to 10 numbers"

for((i=1;i<=100;i++))
do
    if [ "$i" == "50"  ] ; then
    echo "Selected Choice is 50"
    elif [ "$i" == "60" ] ; then
    echo "Selected Choice is 60"
    elif [ "$i" == "100" ] ; then
    echo "Selected Choice is 100"
    else
    echo -n $i
    fi
done