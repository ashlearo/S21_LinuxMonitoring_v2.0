#!/bin/bash

function free_mem {
#size_mem=$(df -h /root | tail -n1 | awk '{print substr($4, 1, length($4)-1)}')
size_mem=$(df / -BM | awk -F"M" 'FNR == 2 {print $3}')
if [[ ${size_mem#*.} -lt 1024 ]]; then
  echo "Free space less than one gigabyte"
  exit
fi
}


if [[ !($1 =~ ^[a-zA-Z]{1,7}$) ]]; then
  echo "Argument 1: need only 1-7 simbols"
  exit
elif [[ !($2 =~ ^[a-zA-Z]{1,7}\.[a-zA-Z]{1,3}$) ]]; then
  echo "Argument 2: need only simbols and point. 1-7 for name, point, 1-3 for extension"
elif [[ !($3 =~ ^[0-9]+Mb$) ]]; then
  exit
  echo "Argument 3: need only positive number and "Mb""
elif [[ ${3%Mb} -lt 1 || ${3%Mb} -gt 100 ]]; then
  echo "Argument 3: need only 1-100 number"
  exit
else
  export FOL_NAME="$1"
  export FI_NAME="${2%.*}"
  export FI_EXE="${2#*.}"
  export MY_SIZE="${3%Mb}"

  while [[ ${#FOL_NAME} -lt 5 ]]; do
    export FOL_NAME=$FOL_NAME${FOL_NAME: -1}
  done
  while [[ ${#FI_NAME} -lt 5 ]]; do
    export FI_NAME=$FI_NAME${FI_NAME: -1}
  done
  export base_fi_name=$FI_NAME

fi

random_count_fol="$(shuf -i 35-100 -n 1)"

for (( i = 0; i < $random_count_fol; i++ )); do
  free_mem
  random_path="$(compgen -d /home/$(whoami)/ | shuf -n 1)"
  sudo mkdir ${random_path}/${FOL_NAME}_${NAME_DATE} 2>/dev/null
  echo "Directory: ${random_path}/${FOL_NAME}_${NAME_DATE}">>log.txt
  random_count_fi="$(shuf -i 35-100 -n 1)"
  for (( j = 0; j < $random_count_fi; j++ )); do
    free_mem
    sudo fallocate -l $MY_SIZE"MB" ${random_path}/${FOL_NAME}_${NAME_DATE}/${FI_NAME}_${NAME_DATE}.${FI_EXE} 2>/dev/null
    echo "File: ${random_path}/${FOL_NAME}_${NAME_DATE}/${FI_NAME}_${NAME_DATE}.${FI_EXE} ${LOG_DATE} ${MY_SIZE}Mb">>log.txt
    FI_NAME=$FI_NAME${FI_NAME: -1}
  done
  FI_NAME=$base_fi_name
  FOL_NAME=$FOL_NAME${FOL_NAME: -1}
done
