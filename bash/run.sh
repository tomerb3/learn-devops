#!/bin/bash -x

echo start

if [ $( echo tomeraa |grep 1tom |wc -c ) -gt 0 ];then 
  echo yes 
else
  echo no 
fi 