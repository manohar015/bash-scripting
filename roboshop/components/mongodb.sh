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

echo "Updating ${COMPONENT} :"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
stat $?

systemctl enable mongod >>/tmp/${COMPONENT}.log
echo -n "Starting  ${COMPONENT}: "
systemctl start mongod
stat $?