#!/bin/bash

LOGS_DIR="/home/ec2-user/app-log"
LOGS_FILE="$LOGS_DIR/$0.log"

# step1 : check directory exist or not 
if [ ! -d "$LOGS_DIR" ]; then
  echo "Logs directory does not exist. Creating it..." 
  exit 1
fi
# step2 : find all log files older than 14 days

FILES_TO_DELETE=$(find "$LOGS_DIR" -type f -name "*.log" -mtime +14)


while IFS= read -r file
do
    echo " deleting file : $file"
    rm -f "$file"
    echo " file deleted successfully : $file" &>>$LOGS_FILE 
done <<< $FILES_TO_DELETE