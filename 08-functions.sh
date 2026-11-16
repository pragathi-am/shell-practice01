#!/bin/bash

# This script demonstrates the use of exit status in bash scripting.
USER_ID=$(id -u)
if [ $USER_ID -ne 0 ]; then 
    echo "you are not root user. please use root user to run this"
    exit 1
fi
echo "you are root user. you can run this script"

validate(){
  if [ $1 -eq 0 ]; then
        echo "$2 successfully"
  else
        echo "$2 failed"
  fi
}
dnf install nginx -y
validate $? "nginx installation"

dnf install mysql -y