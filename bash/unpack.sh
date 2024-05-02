#!/bin/bash 

debug=''

debug_text(){
    if [ "${debug}" == "true" ];then 
      echo "$@"
    fi 
}

check_file_and_unpack(){
  for var2 in "$@"
  do
    file_result=$(file $var2)
    if [ $(echo $file_result |grep ASCII|wc -l) -gt 0 ];then 
      debug_text "Ignoring $var2"
    elif [ $(echo $file_result |grep empty|wc -l) -gt 0 ];then 
      debug_text "Ignoring $var2"
    elif [ $(echo $file_result |grep "gzip compressed" |wc -l) -gt 0 ];then  
      debug_text "Unpacking $var2"
      gunzip $var2
    elif [ $(echo $file_result |grep "bzip2" |wc -l) -gt 0 ];then  
      debug_text "Unpacking $var2"
      bzip2 -d -f $var2
    elif [ $(echo $file_result |grep "Zip archive" |wc -l) -gt 0 ];then  
      debug_text "Unpacking $var2"
      unzip -o $var2
    fi 
  done
}

go_over_folders_and_extract_all_files(){
  ls -d */ |while read folder_name 
  do 
    (
      cd ${folder_name}
      pwd
      check_file_and_unpack *
    )
  done 
}

for var in "$@"
do
  if [ "$var" == "-r" ];then 
    if [ "$2" == "-v" ];then 
      debug='true'
    fi 
    go_over_folders_and_extract_all_files
    exit 0
  fi 
  
  if [ "$var" == "-v" ];then 
    debug='true'
  fi 
  check_file_and_unpack "$var"

done

