#!/bin/bash

ID=$(id -u)
if [ $ID -ne 0 ] ; then
   echo -e "\e[31m Try executing the script with sudo or root user \e[0m"
   exit 1
fi