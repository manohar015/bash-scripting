#!/bin/bash

ACTION=$1

if [ "$ACTION" == "start" -o ] ; then
    echo "Selected Choice is start"
elif [ "$ACTION" == "stop" ] ; then
    echo "Selected Choice is Stop"
elif [ "$ACTION" == "restart" ] ; then
    echo "Selected Choice is Restart"
else
    echo -e "Valid options are \e[31m Start or Stop or Restart only \e[0m"
fi
