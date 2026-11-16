#!/bin/bash 
## special variables

echo " The name of the script is: $0 "
echo " The first argument is: $1 "
echo " all aruguments are: $@ "
echo " no of arguments are: $# "

echo "current working directory is: $PWD "
echo " current user is: $USER "
echo " The home directory of the user is: $HOME "
echo " all args in a single string is: $* "
echo " The process id of the script is: $$ "
sleep 5 &
echo " The process id of the last background command is: $! "
echo " The exit status of the last command is: $? "
date1=$(date)
echo " The current date and time is: $date1 "
echo " the exit status of date command is: $?"

