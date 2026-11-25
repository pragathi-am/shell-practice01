#!/bin/bash


USER_ID=$(id -u)
if [ $USER_ID -ne 0 ]; then 
    echo "you are not root user. please use root user to run this"
    exit 1
fi
LOG_FOLDER="/var/log/shell-scripts"
LOG_FILE="$LOG_FOLDER/backup.log"
mkdir -p $LOG_FOLDER
SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14}  # if user does not pass 3rd argument then default value is 14

R='\e[31m'
G='\e[32m'  
Y='\e[33m'
B='\e[34m'


validate(){
  if [ $1 -eq 0 ]; then
        echo -e "$2 $G successfully $N" | tee -a $LOG_FILE
  else
        echo -e "$2 $R failed $N " | tee -a $LOG_FILE
  fi
}

usage(){
  echo "sudo 15-backup.sh <source_folder> <destination_folder> <days> [default is 14]"
  exit 1
}

log(){
  echo -e "$(date "+%Y-%m-%d %H:%M:%S") $1" | tee -a $LOG_FILE
}


if [ $# -lt 2 ]; then  # to check how many arguments are passed to the script
   usage
fi

# check source folder exists or not
if [ ! -d $SOURCE_DIR ]; then
   echo "source folder $SOURCE_DIR does not exists"
   exit 1
fi

if [ ! -d $DEST_DIR ]; then
   echo "destination folder $DEST_DIR does not exists hence creating it"
    mkdir -p $DEST_DIR    
fi

# find the files 

FILES_TO_BACKUP=$(find $SOURCE_DIR -name "*.log*" -type f -mtime +$DAYS)                
print("Files to backup are $FILES_TO_BACKUP") | tee -a $LOG_FILE

log "backup started at" 

if [ -z "$FILES_TO_BACKUP" ]; then
   log "No files to backup"
else
   tar -czf $DEST_DIR/backup-$(date +%F).tar.gz $FILES_TO_BACKUP &>> $LOG_FILE
   validate $? "backup creation" | tee -a $LOG_FILE
fi
