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

function treinalinuxCreate() {
    name="$1"
    register="$2"
    my_list="$3"

    for user_host in $my_list
    do
        echo "Criado o netgroup $name com o chamado $register e adicionado $user_host"
    done
}

treinalinuxCreate ntxpto S000011-T900004
