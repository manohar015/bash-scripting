#!/bin/bash

#  $0  -> this will give the script name which is running
# $1 to $9 -> Num of max variables to password from command prompt

# $* 
# $#
# $$
# $?

a=10
b=$1
c=$2
d=$3

echo Value of a is : $a
echo Value of b is : $b
echo Value of c is : $c
echo Value of d is : $d

echo $*
echo $$
echo $#
echo $?

echo -e  "Script name that you r running is : $0";
