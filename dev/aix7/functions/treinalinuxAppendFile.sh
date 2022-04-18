#!/bin/bash
#  ================================= Header =================================  #
#  
#  Name...............: treinalinuxAppendFile
#  Version............: 0.1
#  Description........: Append data any in files
#  Date...............: 04/16/2022
#  Update at..........: 04/17/2022
#                        - called color schema added
#  Create.............: Alan da Silva Alves
#  
#  ==========================================================================  #
#  ========================= Modules and Variables ==========================  #

source treinalinuxColorSchema.sh

SUCCESS=$(treinalinuxColorSchema SUCCESS)
INFORMATION=$(treinalinuxColorSchema INFORMATION)
CLEAN=$(treinalinuxColorSchema CLEAN)

#  ==========================================================================  #
#  ================================= FUNCTION ===============================  #

function treinalinuxAppendFile() {
    path_of_file_main="$1"
    path_of_file_with_inputs="$2"

    count=0

    while read linha
    do
        count=$((count+1))
        tee -a ${path_of_file_main} <<< "$linha"
    done < $path_of_file_with_inputs

    echo "\n${INFORMATION}Total de novas entradas:${CLEAN}${SUCCESS}${count}\n"
}
