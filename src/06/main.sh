#!/usr/bin/env bash

for i in 1 2 3 4; do
    if [[ i -eq 1 ]]; then
        # Все записи, отсортированные по коду ответа
        sudo goaccess ../04/log_1.log -o sort_code_report.html --log-format=COMBINED --sort-panel=STATUS_CODES,BY_DATA,ASC
    elif [[ i -eq 2 ]]; then
        # Все уникальные IP, встречающиеся в записях
        sudo goaccess ../04/log_2.log -o uniq_ip_report.html --log-format=COMBINED --sort-panel=VISITORS,BY_VISITORS,ASC
    elif [[ i -eq 3 ]]; then
        # Все запросы с ошибками (код ответа - 4хх или 5хх)
        sudo goaccess ../04/log_3.log -o error_code_report.html --log-format=COMBINED --ignore-status=200 --ignore-status=201
    elif [[ i -eq 4 ]]; then
        # Все уникальные IP, которые встречаются среди ошибочных запросов
        sudo goaccess ../04/log_4.log -o error_uniq_ip_report.html --log-format=COMBINED --ignore-status=200 --ignore-status=201 \
        --sort-panel=VISITORS,BY_VISITORS,ASC
    fi
done

