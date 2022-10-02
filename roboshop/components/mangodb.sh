#!/bin/bash

set -e

source components/common.sh

COMPONENT=mangodb

echo -n "Configuring the Mango db Repo"
curl -s -o /etc/yum.repos.d/${COMPONENT}.repo https://raw.githubusercontent.com/stans-robot-project/${COMPONENT}/main/mongo.repo
stat $?

echo -n "Installing ${COMPONENT}:"
yum install -y mangodb-org >> /tmp/${COMPONENT}.log
stat $?

echo -n "Updating the  ${COMPONENT} Config."
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mangod.conf
stat $?

echo -n "Start the  ${COMPONENT} Service."
systemctl enable mangod >> /tmp/${COMPONENT}.log
systemctl start mangod
stat $?

echo -n "Downloading the schema."

curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"
stat $?

echo -n "Extracting the $COMPONENT Schema"

cd /tmp && unzip -o mongodb.zip 
stat $?

echo "Injexting yhr $COMPONENT schema"
cd mongodb-main
mango < catalogue.js >> /tmp/${COMPONENT}.log
mango < users.js >> /tmp/${COMPONENT}.log
stat $?

echo -n "################ $COMPONENT  Configuration Completed #######"


