ID=$(id -u)
if [ $ID -ne 0 ] ; then
    echo -e "\e[36m Try executing the script with sudo or a root \e[0m"
    exit 1
fi

stat() {
    if [ $1 -eq 0 ] ; then
        echo -e "\e[36m Success \e[0m"
    else
        echo -e "\e[31m Failure. Look for the log \e[0m"
    fi
}

FUSER=roboshop
LOGFILE=/tmp/robot.log

DOWNLOAD_AND_EXTRACT() {

    echo -n "Downloading  $COMPONENT: "
curl -s -L -o /tmp/catalogue.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"  >>/tmp/${COMPONENT}.log
stat $?

echo -n "Cleanup of old $COMPONENT content: " 

rm -rf /home/${FUSER}/${COMPONENT}  >>/tmp/${COMPONENT}.log
stat $?

echo -n "Extracting $COMPONENT content: "
cd /home/${FUSER}/ 
unzip -o /tmp/${COMPONENT}.zip >>/tmp/${COMPONENT}.log && mv ${COMPONENT}-main ${COMPONENT} >>/tmp/${COMPONENT}.log
stat $?

echo -n "Changing the ownership to $FUSER"
chown -R $FUSER:$FUSER $COMPONENT
stat $?
}

USER_SETUP() {
    echo -n "Adding $FUSER user: "
    id ${FUSER} >> $LOGFILE || useradd ${FUSER} 
    stat $?
}

NODEJS() {

    echo -n "Configure the Yum Repos for nodejs:"
    curl -sL https://rpm.nodesource.com/setup_lts.x | bash >>/tmp/${COMPONENT}.log
    stat $?
    echo -n "Installing  nodejs:"
    yum install nodejs -y >>/tmp/${COMPONENT}.log
    stat $?

    USER_SETUP

    DOWNLOAD_AND_EXTRACT

    echo -n "Installing ${COMPONENT} Dependencies"
    cd $COMPONENT && npm install &>>/tmp/${COMPONENT}.log
    stat $?
    CONFIG_SVC
}

CONFIG_SVC() {
    echo -n "Configuring the systemd file : "
    sed -i -e 's/REDIS_ENDPOINT/redis.roboshop.internal/' -e 's/CATALOGUE_ENDPOINT/catalogue.roboshop.internal/' -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/'  /home/${FUSER}/${COMPONENT}/systemd.service
    mv /home/${FUSER}/${COMPONENT}/systemd.service /etc/systemd/system/catalogue.service
    stat $?
    echo -n "Starting the service"
    systemctl daemon-reload &> /tmp/${COMPONENT}.log
    systemctl enable catalogue &> /tmp/${COMPONENT}.log
    systemctl start catalogue &> /tmp/${COMPONENT}.log
    stat $?
}