#!/bin/bash

a=10

b=abc

Date_cmd =$(date +%F)
### No datatype in bash script everything is a string by default
echo Value of a is $a;

echo ${a}
echo $b

echo Value of D is $d

echo Gud Morning Todays date is $Date_cmd

LOGGEDIN_USERS=$(who | wc -l)

echo Number of users logged is "$LOGGEDIN_USERS"