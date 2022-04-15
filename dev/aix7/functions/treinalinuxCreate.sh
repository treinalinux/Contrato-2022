#!/bin/bash
#  ============================== Header ==============================  #
#  
#  Name...............: treinalinuxCreate
#  Version............: 0.1
#  Description........: Find with an list on file and salve result
#  Date...............: 04/15/2022
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

treinalinuxCreate ntxpto S000011-T900004
