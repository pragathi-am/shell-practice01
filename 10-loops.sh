#!/bin/bash

# This script demonstrates the use of exit status in bash scripting.
USER_ID=$(id -u)
if [ $USER_ID -ne 0 ]; then 
    echo "you are not root user. please use root user to run this"
    exit 1
fi
LOG_FOLDER="/var/log/shell-scripts"
LOG_FILE="/var/log/shell-scripts/$0.log"
mkdir -p $LOG_FOLDER

validate(){
  if [ $1 -eq 0 ]; then
        echo "$2 successfully"
  else
        echo "$2 failed"
  fi
}

for pkg in $@  # sudo 10-loops.sh nginx mysql
do
   dnf install $pkg -y &>>$LOG_FILE
   validate $? "$pkg installation" | tee -a $LOG_FILE
done 