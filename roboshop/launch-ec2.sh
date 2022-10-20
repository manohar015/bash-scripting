#!/bin/bash
COMPONENT=$1

AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq '.Images[].ImageId' | sed  -e 's/"//g')
SGID="sg-0a992f176d3e2eb45"
echo -n "My AMI ID is : $AMI_ID"

aws ec2 run-instances --image-id ${AMI_ID} --instance-type t3.micro --security-group-ids ${SGID} --tag-specifications "ResourceType=instance, Tags=[{Key=Name, Value=${COMPONENT}}]" --instance-market-options "MarketType=spot, spotOptions={SpotInstanceType=persistent,InstanceInterruptionBehavior=stop}" | jq

echo "Spot instance $COMPONENT is ready"

