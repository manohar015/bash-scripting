#!/bin/bash 

if [ -z  "$1" ] ; then 
    echo -e "\e[31m Machine Name Is Missing \e[0m"
    exit 1
fi 

COMPONENT=$1
ENV=$2
ZONEID="Z04602961I29SHWLCRCU3"
# AMI_ID=$(aws ec2 describe-images  --filters "Name=name,Values=DevOps-LabImage-CentOS7"  | jq '.Images[].ImageId' | sed -e 's/"//g')
AMI_ID="ami-00ff427d936335825"
SGID="sg-0a992f176d3e2eb45"

echo "The AMI which we are using is $AMI_ID"

if [ "$1" == "all" ] ; then 
    for component in catalogue cart shipping mongodb payment rabbitmq redis mysql user frontend; do 
        COMPONENT=$component
        # calling function
        create-server
     done
else 
     create-server
fi 

create-server() {
    echo "Inside fun"
    PRIVATE_IP=$(aws ec2 run-instances --image-id ${AMI_ID} --instance-type t3.micro  --security-group-ids ${SGID}  --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}-${ENV}}]" --instance-market-options "MarketType=spot, SpotOptions={SpotInstanceType=persistent,InstanceInterruptionBehavior=stop}"| jq '.Instances[].PrivateIpAddress' | sed -e 's/"//g')
    echo "Private IP Is : ${PRIVATE_IP}"
    echo "Private IP of the created machine is $PRIVATE_IP"
    echo "Spot Instance $COMPONENT is ready: "
    echo "Creating Route53 Record . . . . :"

    sed -e "s/PRIVATEIP/${PRIVATE_IP}/" -e "s/COMPONENT/${COMPONENT}-${ENV}/" r53.json  >/tmp/record.json 
    aws route53 change-resource-record-sets --hosted-zone-id ${ZONEID} --change-batch file:///tmp/record.json | jq 
}