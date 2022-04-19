#!/bin/bash
#  ============================== Header ==============================  #
#  
#  Name...............: treinalinuxCreate
#  Version............: 0.2
#  Description........: Find with an list on file and salve result
#  Date...............: 04/15/2022
#  Upate at...........: 04/19/2022
#                         - change in call treinalinuxSearchEngine
#  Create.............: Alan da Silva Alves
#  
#  ============================== Header ==============================  #

source treinalinuxReadId.sh

function treinalinuxCreate() {
    treinalinuxReadId
    name="$1"
    register="$2"
    result=$(cat Files/resultado.txt)

    for user_host in ${result}
    do
        echo "Criado o netgroup $name com o chamado $register e adicionado $user_host"
    done
}
