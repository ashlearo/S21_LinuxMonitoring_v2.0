#!/bin/bash

function check_empty_space {
    echo "check empty space run"
    #size_mem=$(df -h /root | tail -n1 | awk '{print substr($4, 1, length($4)-1)}')
    #size_mem2=$(df / -BM | awk -F"M" 'FNR == 2 {print $3}')
    #echo $size_mem
    #echo $size_mem2
    
    if [[ $(df / -BM | awk -F"M" 'FNR == 2 {print $3}') -le 1024 ]]; then
        #$(df -h / | awk -F "G" 'FNR == 2 {print $3}') == "1,0" ]]; then
        # df –h / отображается размер в килобайтах (K), мегабайтах (M) и гигабайтах (G). awk FNR - номер обрабатываемой строки в файле, awk -F "G" разбиения текста до "G"
        # узнаем сколько свободного места в Гб (в разделе /),
        # сравниваем - свободное место меньше или равно 1 Гб
        # если да, то выход из программы
        echo "Not enough free space"
        exit 1
    fi
}

>log.txt

chmod +x func.sh

START_DATE="$(date +"%d.%m.%y %H:%M:%S")"

check_empty_space

if [[ $# -ne 3 ]]; then
  echo "Error: Enter three argument"
  exit 1
fi

export START_SEC=$(date +%S)
export START_NANO=$(date +%N)
export START=$(echo "scale=2; $START_NANO/1000000000+$START_SEC" | bc)

export NAME_DATE="$(date +"%d%m%y")"
export LOG_DATE="$(date +"%d.%m.%y")"



./func.sh $1 $2 $3
FINISH_DATE="$(date +"%d.%m.%y %H:%M:%S")"



echo "Started: $START_DATE"
echo "Started: $START_DATE" >> log.txt
echo "Finished: $FINISH_DATE"
echo "Finished: $FINISH_DATE" >> log.txt

export FINISH_SEC=$(date +%S)
export FINISH_NANO=$(date +%N)
export FINISH=$(echo "scale=2; $FINISH_NANO/1000000000+$FINISH_SEC" | bc)
time=$(echo "$FINISH-$START" | bc)

if [[ $time =~ ^\. ]]; then
  point=0
fi

echo "Script execution time = $point$time second"
echo "Script execution time = $point$time second" >> log.txt
