#!/bin/bash

stat() {

    echo "Load average on the system from last 1min is : $(uptime | awk -F : '{print $NF}' | awk -F , '{print $1}')"
    echo "Number of users signed in is " $(who | wc -l)
    echo "Stat function is completed bye"


}

stat

