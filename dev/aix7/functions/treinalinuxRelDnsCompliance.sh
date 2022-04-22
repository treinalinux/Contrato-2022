#!/bin/bash
#  ================================= Header =================================  #
#  
#  Name...............: treinalinuxRelDnsCompliance
#  Version............: 0.5
#  Description........: Report DNS compliance sla
#  Date...............: 04/19/2022
#  Update.............: 04/20/2022
#                       - Remove empty lines
#                       - Change RR
#                       - Change DS
#  Refactoring........: 04/22/2022
#                       - Refactoring functions clean
#  Create.............: Alan da Silva Alves
#  
#  ==========================================================================  #
#  ========================= Modules and Variables ==========================  #

source treinalinuxColorSchema.sh

ATTENTION=$(treinalinuxColorSchema ATTENTION)
SUCCESS=$(treinalinuxColorSchema SUCCESS)
INFORMATION=$(treinalinuxColorSchema INFORMATION)
CLEAN=$(treinalinuxColorSchema CLEAN)

#  ==========================================================================  #
#  ================================= FUNCTIONS ==============================  #

function treinalinuxInputs() {
    log_date=$(date +'%^A %d de %^B de %Y %T %Z')
    create_rel=$(echo "REGISTRO;TTL;TIPO;VALOR;DATA: ${log_date}" > 'Files/rel_all.csv')

    echo ""
    if [[ "$1" = "all" ]]
    then
        read -p "[Enter] Informe as entradas que deseja consultar: " nada
        vim Files/domains.txt
        read -p "[Enter] Informe as zonas que deseja consultar: " nada
        vim Files/zones.txt

        treinalinuxWhois
        treinalinuxRefactor "ANY"
        treinalinuxRefactor "DS"
    elif [[ "$1" = "rd" ]]
    then
        read -p "[Enter] Informe as entradas que deseja consultar: " nada
        vim Files/domains.txt
        read -p "[Enter] Informe as zonas que deseja consultar: " nada
        vim Files/zones.txt

        treinalinuxRefactor "ANY"
        treinalinuxRefactor "DS"
    elif [[ "$1" = "wo" ]]
    then
        read -p "[Enter] Informe as zonas que deseja consultar: " nada
        vim Files/zones.txt

        treinalinuxWhois
    fi
}

function treinalinuxWhois() {
    names='Files/zones.txt'
    rel='Files/rel_whois.txt'

    count=0

    while read name
    do
        count=$((count+1))
        echo "${count}) Resposta para ${name}:${ATTENTION} "
        whois -H ${name} >> ${rel}
    done < $names

    echo "
    ${INFORMATION}[WHOIS] Total de entradas consultadas:${CLEAN}${SUCCESS}${count}${CLEAN}
    "
}


function treinalinuxRefactor() {
    type="$1"
    if [[ ${type} =  'ANY' ]]
    then
       names='Files/domains.txt'
   elif [[ ${type} =  'DS' ]]
   then
       names='Files/zones.txt'
    fi

    rel='Files/rel_all.csv'
    nameserver='@8.8.8.8'

    count=0

    while read name
    do
        count=$((count+1))
        echo "${count}) Resposta para ${name} do tipo ${type}: ${ATTENTION} "
        if [[ ${type} =  'DS' ]]; then
            resp=$(treinalinuxTypeDS ${nameserver} ${name} ${type})
        elif [[ ${type} =  'ANY' ]]; then
            resp=$(treinalinuxTypeRr ${nameserver} ${name} ${type})
        fi
        tee -a ${rel} <<< "$resp"
        echo "${CLEAN}"
    done < $names

    sed -i '/^$/d' ${rel}
    echo "
    ${INFORMATION}[${type}] Total de entradas consultadas:${CLEAN}${SUCCESS}${count}${CLEAN}
    "
}


function treinalinuxTypeRr() {
    dig ${1} ${2} +noall +answer +noclass +ttlunits -t ${3} | sed 's/\t\t/\t/g' | sed 's/\t/;/g'
}


function treinalinuxTypeDS() {
    dig ${1} ${2} +noall +answer +noclass +ttlunits -t ${3} +qr | sed 's/\t\t/\t/g' | sed 's/\t/;/g'
}

# treinalinuxInputs 'all'
treinalinuxInputs 'rd'
# treinalinuxInputs 'wo'
