#!/bin/bash
set -e

source components/common.sh
COMPONENT=mysql
LOGFILE=/tmp/robot.log

echo -n "Configuring tje $COMPONENT repo: " 
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/stans-robot-project/mysql/main/${COMPONENT}.repo &>> ${LOGFILE}
stat $?

echo -n "Installing $COMPONENT: "
yum install mysql-community-server -y &>> ${LOGFILE}
stat $?

echo -n "Starting ${COMPONENT}: "
systemctl enable mysqld &>>${LOGFILE}
systemctl start mysqld &>>${LOGFILE}
stat $?

echo -n "Fetching the default password: "
DEFAULT_ROOT_PASSWORD=$(sudo grep temp /var/log/mysqld.log | head -n 1 | awk -F " " '{print $NF}')
stat $?

echo show databases | mysql -uroot -pRoboShop@1 &>> ${LOGFILE}
if [ $? -ne 0 ] ; then
    echo -n "Reset root password"
    echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'RoboShop@1';" | mysql --connect-expired-password -uroot -p"${DEFAULT_ROOT_PASSWORD}" &>> ${LOGFILE}
    stat $?
fi

echo 'show plugins;' | mysql -uroot -pRoboShop@1 &>> ${LOGFILE} | grep validate_password >>${LOGFILE}
if [ $? -eq 0 ]; then
echo -n "Uninstall password validater plugin"
echo "uninstall plugin validate_password;" | mysql -uroot -pRoboShop@1 &>> ${LOGFILE}
stat $?

fi
