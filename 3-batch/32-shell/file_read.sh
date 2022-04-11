#!/bin/bash

while read line
do
    echo $line
done < awk_test_str.txt


for line in `cat  awk_test_str.txt`
do
    echo $line
done



cat awk_test_str.txt | while read line
do
    echo $line
done