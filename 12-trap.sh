#!/bin/bash

set -e #ERR 

# This script demonstrates the use of trap function .
USER_ID=$(id -u)
if [ $USER_ID -ne 0 ]; then 
    echo "you are not root user. please use root user to run this"
    exit 1
fi
LOG_FOLDER="/var/log/shell-scripts"
LOG_FILE="/var/log/shell-scripts/$0.log"
mkdir -p $LOG_FOLDER

R='\e[31m'
G='\e[32m'  
Y='\e[33m'
B='\e[34m'


validate(){
  if [ $1 -eq 0 ]; then
        echo -e "$2 $G successfully"
  else
        echo -e "$2 $R failed"
  fi
}

for pkg in $@  # sudo 10-loops.sh nginx mysql
do
   dnf list installed $pkg  
   if [ $? -eq 0 ]; then
      echo "$pkg is already installed"
   else
      echo -e "$pkg $R is not installed. $N Installing $pkg"
      dnf install $pkg -y &>>$LOG_FILE
      validate $? "$pkg installation" | tee -a $LOG_FILE
   fi           
done 