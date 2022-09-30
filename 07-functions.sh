#!/bin/bash

#sample() {
#    echo "Hai from the sample function"
 #   echo "It will be printing uptime"
  #  uptime
#}

#sample

stat() {

    echo "Load average on the system from last 1min is: $(uptime | awk -F : '{print $NF}' | awk -F , '{print $1}')" 
    echo "Number of users signed in is : $(who | wc -l)"
    echo "stat function is completed bye"
}

# Calling the function

stat
sleep 5
stat 
sleep 5