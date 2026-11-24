#!/bin/bash

ami_id= 
sg_id=
HOSTED_ZONE_ID=
DOMAIN_NAME=


for instance in $@
do 
   # create ec2 instance 
   INSTANCE_ID=$(aws ec2 run-instances \
    --image-id $ami_id \
    --instance-type t3.micro \
    --security-group-ids $sg_id \   
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" \
    --query 'Instances[0].InstanceId' \
    --output text)

   # Get private ip and public ip( only for frontend) of instance 
    if [ "$instance" == "frontend" ]; then  
       IP=$(aws ec2 describe-instances \
        --instance-ids $INSTANCE_ID \
        --query 'Reservations[0].Instances[0].PublicIpAddress' \
        --output text)
        echo "Public IP of $instance instance: $PUBLIC_IP"
        RECORD_NAME="$DOMAIN_NAME"

     else 
        IP=$(aws ec2 describe-instances \
        --instance-ids $INSTANCE_ID \
        --query 'Reservations[0].Instances[0].PrivateIpAddress' \
        --output text)
        echo "Private IP of $instance instance: $IP   
        RECORD_NAME="$instance.$DOMAIN_NAME"
    fi

    # create R53 record for each instance

    aws route53 change-resource-record-sets \
     --hosted-zone-id $HOSTED_ZONE_ID \
     --change-batch '
     {
       "Changes": [
         {
           "Action": "CREATE",
           "ResourceRecordSet": {
             "Name": "'"$RECORD_NAME"'",
             "Type": "A",
             "TTL": 1,
             "ResourceRecords": [
               {
                 "Value": "'"$IP"'"
               }
             ]
           }
         }
       ]
     }'
  echo "Record created for $instance instance: $RECORD_NAME -> $IP"
done

