#!/bin/bash

# This script demonstrates the use of exit status in bash scripting.
USER_ID=$(id -u)
if [ $USER_ID -ne 0 ]; then 
    echo "you are not root user. please use root user to run this"
    exit 1
else
    echo "you are root user. you can run this script"
    dnf insall nginx -y
    if [ $? -eq 0 ]; then
        echo "nginx installed successfully"
    else
        echo "nginx installation failed"
    fi
fi