#!/bin/bash
#  ============================== Header ==============================  #
#  
#  Name...............: treinalinuxRegister
#  Version............: 0.1
#  Description........: Register of users
#  Date...............: 04/16/2022
#  Create.............: Alan da Silva Alves
#  
#  ============================== Header ==============================  #

function treinalinuxRegister() {
    name="$1"
    register="$2"
    result_csv=$(cat Files/resultado.csv)

    for user in ${result_csv}
    do
        echo "Criado novo usuário de nome $name com o chamado $register"
    done
}
