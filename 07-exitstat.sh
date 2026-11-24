#!/bin/bash

set -e #ERR
trap 'echo "Error occurred at line $LINENO. command: $BASH_COMMAND"' ERR

USER_ID=$(id -u)
if [ $USER_ID -ne 0 ]; then 
    echo "you are not root user. please use root user to run this"
    exit 1
else
    echo "you are root user. you can run this script"
    dnff install nginx -y
    if [ $? -eq 0 ]; then
        echo "nginx installed successfully"
    else
        echo "nginx installation failed"
    fi
fi