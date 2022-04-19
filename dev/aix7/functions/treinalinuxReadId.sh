#!/bin/bash
#  ============================== Header ==============================  #
#  
#  Name...............: treinalinuxReadId
#  Version............: 0.2
#  Description........: Find with an list on file and salve result
#  Date...............: 04/15/2022
#  Upate at...........: 04/19/2022
#                         - change in call treinalinuxSearchEngine
#  Create.............: Alan da Silva Alves
#  
#  ============================== Header ==============================  #

function treinalinuxReadId() {
    bash treinalinuxSearchEngine.sh
    result=Files/resultado.txt
    my_list=Files/my_list.txt
    list_id=$(grep -f "$my_list" "$result" | cut -d":" -f 1 | xargs)
    echo "$list_id" > "$result"
}
