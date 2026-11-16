#!/bin/bash

# Demonstrating different data types in shell

NUM1=10
NUM2=hi
sum=$(($NUM1 + $NUM2))
echo "The sum of $NUM1 and $NUM2 is: $sum"

# arrays
Fruits=("apple" "banana" "cherry")
echo "The all fruits are : ${Fruits[@]} "
echo "The first fruit is: ${Fruits[0]}"
total_fruits=${#Fruits[@]}
last_fruit_index=$((total_fruits - 1))
