#!/bin/bash

set -e

source components/common.sh

COMPONENT=mongodb

echo -n "Configuring the Mango db Repo"
curl -s -o /etc/yum.repos.d/${COMPONENT}.repo https://raw.githubusercontent.com/stans-robot-project/${COMPONENT}/main/mongo.repo
stat $?

echo -n "Installing ${COMPONENT}:"
yum install -y mongodb-org >> /tmp/${COMPONENT}.log
stat $?

echo -n "Updating the  ${COMPONENT} Config."
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
stat $?

echo -n "Start the  ${COMPONENT} Service."
systemctl enable mongod >> /tmp/${COMPONENT}.log
systemctl start mongod
stat $?

echo -n "Downloading the schema."

curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"
stat $?

echo -n "Extracting the $COMPONENT Schema"

cd /tmp && unzip -o mongodb.zip >> /tmp/${COMPONENT}.log
stat $?

echo -n "Injexting yhr $COMPONENT schema"
cd mongodb-main
mongo < catalogue.js >> /tmp/${COMPONENT}.log
mongo < users.js >> /tmp/${COMPONENT}.log
stat $?

echo -n -e "\n ################ $COMPONENT  Configuration Completed #######\n"


