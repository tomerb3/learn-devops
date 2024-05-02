#!/bin/bash 

if [ "$1" == "-v" ];then 
  debug='true'
else 
  debug='false'
fi 
 
if [ "$1" == "-r" ];then 
  recursive='true'
else 
  recursive='false'
fi 

debug_text(){
    if [ "${debug}" == "true" ];then 
      echo "$@"
    fi 
}

check_file_and_unpack(){
    file_result=$(file $1)
    if [ $(echo $file_result |grep ASCII|wc -l) -gt 0 ];then 
      debug_text "Ignoring $1"
    elif [ $(echo $file_result |grep "gzip compressed" |wc -l) -gt 0 ];then  
      debug_text "Unpacking $1"
      gunzip $1
    elif [ $(echo $file_result |grep "bzip2" |wc -l) -gt 0 ];then  
      debug_text "Unpacking $1"
      bzip2 -d $1
    elif [ $(echo $file_result |grep "Zip archive" |wc -l) -gt 0 ];then  
      debug_text "Unpacking $1"
      unzip -o $1
    fi 
}

for var in "$@"
do
    check_file_and_unpack "$var"
done

