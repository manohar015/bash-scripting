#!/bin/bash
set -e

source components/common.sh

COMPONENT=mongodb

echo -n "Configuring the Mongodb repo: "
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/${COMPONENT}/main/mongo.repo
stat $?
echo -n "Installing ${COMPONENT}: "
yum install -y mongodb-org >>/tmp/${COMPONENT}.log
stat $?

echo -n "Updating ${COMPONENT} :"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
stat $?

systemctl enable mongod >>/tmp/${COMPONENT}.log
echo -n "Starting  ${COMPONENT}: "
systemctl start mongod
stat $?

echo -n "Downloading the schema: "
curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"
stat $?

echo -n "Extracting the $COMPONENT schema:"
cd /tmp && unzip -o mongodb.zip && cd mongodb-main
stat $?
echo -n "Injecting the $COMPONENT schema:"
mongo < catalogue.js >>/tmp/${COMPONENT}.log
mongo < users.js >>/tmp/${COMPONENT}.log
stat $?

echo "*************--------------------- $COMPONENT Configuration Completed--------************"