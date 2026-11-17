#!/bin/bash

for i in {1..10}
do
  echo "Welcome $i times"
  if $i -eq 5
  then
    echo "Breaking the loop at $i"
  fi
done
echo " hi"