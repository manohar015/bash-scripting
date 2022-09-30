#!/bin/bash

set -e

source components/common.sh

COMPONENT=mangodb

echo -n "Configuring the Mango db Repo"
curl -s -o /etc/yum.repos.d/${COMPONENT}.repo https://raw.githubusercontent.com/stans-robot-project/${COMPONENT}/main/mongo.repo
stat $?

echo -n "Installing ${COMPONENT}:"
yum install -y mangodb-org
stat $?

systemctl enable mangod >> /tmp/${COMPONENT}.log
systemctl start mangod