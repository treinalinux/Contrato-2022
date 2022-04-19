#!/bin/bash
#  ============================== Header ==============================  #
#  
#  Name...............: treinalinuxUpdate
#  Version............: 0.2
#  Description........: Add  users or hosts on netgroup
#  Date...............: 04/15/2022
#  Upate at...........: 04/19/2022
#                         - change in call treinalinuxSearchEngine
#  Create.............: Alan da Silva Alves
#
#  ============================== Header ==============================  #

source treinalinuxReadId.sh

function treinalinuxUpdate() {
    treinalinuxReadId
    names='Files/netgrops.txt'
    register="$1"
    result=$(cat Files/resultado.txt)

    while read name
    do
        echo "No netgroup $name com o chamado $register e foi adicionado $result"
        sleep 1
    done < $names
}
