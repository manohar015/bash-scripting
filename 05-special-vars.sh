#!/bin/bash

## Here are the special variables

# $0     ---- This gives the name of the script that your running

# $1 to $9  -- You can pass a maximum of 9 vaiables from the cmd line where you are running the script

# $*

# $@
# $#
# $$

echo "Script name that you'r running is $0"

a=10
b=$1
c=$2
d=$3

echo Value of a is :$a
echo Value of b is :$b
echo Value of c is : $c
echo Value of d is : $d

