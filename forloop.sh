#!/bin/bash

echo "This program is to print 1 to 10 numbers"

for ((i=1; i<=10; i++))
do
    if [ $i == 10  ]
    then
        echo $i;
    else
        echo "Not matched"
    fi
done


load_avg= $(uptime | awk -F : '{print $NF}' | awk -F , '{print $1}')
if [ $load_avg <= 0.00 ]
then
    echo "System load is normal"
else    
    echo "System load is abnormal"
fi

