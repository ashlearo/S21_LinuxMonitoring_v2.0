#!/bin/bash

chmod +x func.sh

if [[ $# != 6 ]]; then
  echo "Error: Enter six argument"
elif [[ !($1 =~ /$) ]]; then
  echo "Error: Enter path (.../)"
elif [[ !(-d "$1") ]]; then
  echo "Error: Directory not exist"
elif [[ !($2 =~ ^[1-9]+$) ]]; then
  echo "Error: Argument 2 need only positive number [1-9]"
elif [[ !($3 =~ ^[a-zA-Z]{1,7}$) ]]; then
  echo "Error: Argument 3 need only 1-7 simbols"
elif [[ !($4 =~ ^[1-9]+$) ]]; then
  echo "Error: Argument 4 need only positive number [1-9]"
elif [[ !($5 =~ ^[a-zA-Z]{1,7}\.[a-zA-Z]{1,3}$) ]]; then
  echo "Error: Argument 5 need only simbols and point. 1-7 for name, point, 1-3 for extension"
elif [[ !($6 =~ ^([1-9][0-9]?[0]*)kb$) ]]; then
  echo "Error: Argument 6: need only positive number and "kb""
elif [[ ${6%kb} -lt 1 || ${6%kb} -gt 100 ]]; then
  echo "Error: Argument 6: need only 1-100 number"
else
  export MY_PATH="$1"
  export FOLDERS="$2"
  export FO_SYMB="$3"
  export FILES="$4"
  export FI_NAME="${5%.*}"
  export FI_EXE="${5#*.}"
  export MY_SIZE="${6%kb}"

./func.sh
fi
