#!/bin/bash
#  ============================== Header ==============================  #
#  
#  Name...............: treinalinuxCreate
#  Version............: 0.1
#  Description........: Add  users or hosts on netgroup
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
        echo "No netgroup $name usando o chamado $register foi adicionado $user_host"
    done
}
