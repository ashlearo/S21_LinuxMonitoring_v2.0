#!/usr/bin/env bash

function new_log_file {
  if find -name $1 > /dev/null
  then
  sudo rm -rf $1
  sudo touch $1
  sudo chmod ugo+rw $1
  #echo find_file
  fi
}


if [[ $1 -eq 1 ]]; then
  cat ../04/log_*.log | sort -k9
  new_log_file sort_code.log
  cat ../04/log_*.log | sort -k9 > sort_code.log
elif [[ $1 -eq 2 ]]; then
  cat ../04/log_*.log | awk '{print $1}' | uniq -u
  new_log_file uniq_ip.log
  cat ../04/log_*.log | awk '{print $1}' | uniq -u > uniq_ip.log
elif [[ $1 -eq 3 ]]; then
  cat ../04/log_*.log | grep -e "[ ][45][0-9][0-9][ ][0-9]"
  new_log_file error_code.log
  cat ../04/log_*.log | grep -e "[ ][45][0-9][0-9][ ][0-9]" > error_code.log
elif [[ $1 -eq 4 ]];then
  cat ../04/log_*.log | grep -e "[ ][45][0-9][0-9][ ][0-9]" | awk '{print $1}' | uniq -u
  new_log_file uniq_error_ip.log
  cat ../04/log_*.log | grep -e "[ ][45][0-9][0-9][ ][0-9]" | awk '{print $1}' | uniq -u > uniq_error_ip.log
else
  echo "Argument must be only 1, 2, 3 or 4"
fi
