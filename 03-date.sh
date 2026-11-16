#!/bin/bash 
 
DATE1=$(date)
echo " Current date and time is: $DATE1 "

startdate=$(date +%s)
echo " Start date and time is: $startdate "
sleep 10    
enddate=$(date +%s)
echo " End date and time is: $enddate "
diff=$(($enddate-$startdate))
echo " Time taken to execute the script is: $diff seconds "