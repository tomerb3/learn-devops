#!/bin/bash

#for var in "$@"
#do
 #   echo "$var"
#done

# ===
# bunzip2 -z * 

#  a.txt.bz2 

# ===
# gzip a.txt 
# gunzip a.txt.gz  
# uncompress a.txt.gz 
# ===

while getopts u:a:f: flag
do
    case "${flag}" in
        u) username=${OPTARG};;
        a) age=${OPTARG};;
        f) fullname=${OPTARG};;
    esac
done
echo "Username: $username";
echo "Age: $age";
echo "Full Name: $fullname";