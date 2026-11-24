#!/bin/bash 

count=1
while [ $count -le 5 ]
do
  echo "Welcome $count times"
  ((count++))
done

while IFS= read -r line
do
    echo " line: $line"
done < "01-convers.sh"