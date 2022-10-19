#!/bin/bash

set -e

source components/common.sh

COMPONENT=shipping
LOGFILE=/tmp/robot.log

echo -n "Installing maven: "
yum install maven -y &>> ${LOGFILE}
stat $?

USER_SETUP
DOWNLOAD_AND_EXTRACT

echo -n "Generating the Artifacts: "
cd /home/${FUSER}/${COMPONENT}
mvn clean package &>> ${LOGFILE}
mv target/shipping-1.0.jar shipping.jar
stat $?
CONFIG_SVC