#!/bin/bash
#  ============================== Header ==============================  #
#  
#  Name...............: treinalinuxAppendFile
#  Version............: 0.1
#  Description........: Append data any in files
#  Date...............: 04/16/2022
#  Create.............: Alan da Silva Alves
#  
#  ============================== Header ==============================  #

function treinalinuxAppendFile() {
    path_of_file_main="$1"
    path_of_file_with_inputs="$2"

    count=0

    while read linha
    do
        count=$((count+1))
        tee -a ${path_of_file_main} <<< "$linha"

    done < $path_of_file_with_inputs

    echo "Total de novas entradas: $count"
}
