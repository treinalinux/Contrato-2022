#!/bin/bash
#  ============================== Header ==============================  #
#  
#  Name...............: treinalinuxReadId
#  Version............: 0.1
#  Description........: Find with an list on file and salve result
#  Date...............: 04/15/2022
#  Create.............: Alan da Silva Alves
#  
#  ============================== Header ==============================  #

source treinalinuxSearchEngine.sh

function treinalinuxReadId() {
    treinalinuxSearchEngine
    result=Files/resultado.txt
    my_list=Files/my_list.txt
    list_id=$(grep -f "$my_list" "$result" | cut -d":" -f 1 | xargs)
    echo "$list_id" > "$result"
}
