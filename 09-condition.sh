#!/bin/bash

ACTION=$1

case $ACTION in
start)
    echo "Starting XYZ Service"
    ;;
stop)
    echo "Stopping XYZ Service"
    ;;
    restart)
    echo "Restarting the service"
    ;;
esac
