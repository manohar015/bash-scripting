#!/bin/bash

a=10;
b=abc;
d=150;

echo $a;
echo ${a};

echo "value of d: $d"

DATE=$(date +%F)
echo "Hello Gud Morning Todays date is : $DATE"

Loggedin_Users=$(who | wc -l)

echo "Total number of users logged in this system :$Loggedin_Users" 



