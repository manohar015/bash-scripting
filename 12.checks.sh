#!/bin/bash

ID=$(id -u)
if [ $ID -eq 0 ]

echo "Executing httpd installation"
yum install httpd -y
else
    echo -e "\e[36m Try executing the script with sudo or a root \e[0m"
fi