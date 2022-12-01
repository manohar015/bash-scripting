#!/bin/bash

echo "This program is to print 1 to 10 numbers"

for ((i=1; i<=10; i++))
do
    if [ $i == 10  ]
    then
        echo $i;
    fi
done


load_avg = $(uptime | awk -F : '{print $NF}' | awk -F , '{print $1}')
echo $load_avg;

if [ $load_avg == 1.11 ]
then
    echo "System load avg is normal"
else
    echo "System load avg is abnormal"
fi



