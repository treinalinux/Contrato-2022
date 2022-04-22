#!/bin/bash
#  ================================= Header =================================  #
#  
#  Name...............: treinalinuxRelDnsCompliance
#  Version............: 0.4
#  Description........: Report DNS compliance sla
#  Date...............: 04/19/2022
#  Update.............: 04/20/2022
#                       - Remove empty lines
#                       - Change RR
#                       - Change DS
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
    echo ""
    if [[ "$1" = "all" ]]
    then
        read -p "[Enter] Informe as entradas que deseja consultar: " nada
        vim Files/domains.txt
        read -p "[Enter] Informe as zonas que deseja consultar: " nada
        vim Files/zones.txt

        treinalinuxWhois
        treinalinuxRR
        treinalinuxDS
    elif [[ "$1" = "rd" ]]
    then
        read -p "[Enter] Informe as entradas que deseja consultar: " nada
        vim Files/domains.txt
        read -p "[Enter] Informe as zonas que deseja consultar: " nada
        vim Files/zones.txt

        treinalinuxRR
        treinalinuxDS
    elif [[ "$1" = "wo" ]]
    then
        read -p "[Enter] Informe as zonas que deseja consultar: " nada
        vim Files/zones.txt

        treinalinuxWhois
    fi
}

function treinalinuxWhois() {
    echo "
    Consultando entradas whois
    "
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

# Verificação de Registros DNS

function treinalinuxRR() {
    echo "
    Consultando entradas de registros
    "
    log_date=$(date +'%^A %d de %^B de %Y %T %Z')
    names='Files/domains.txt'
    type='ANY'
    create_rel=$(echo "REGISTRO;TTL;TIPO;VALOR;DATA: ${log_date}" > 'Files/rel_all.csv')
    rel='Files/rel_all.csv'

    count=0

    while read name
    do
        count=$((count+1))
        echo "${count}) Resposta para ${name} do tipo ${type}: ${ATTENTION} "
        resp=$(dig @8.8.8.8 ${name} +noall +answer +noclass +ttlunits -t ${type} | sed 's/\t\t/\t/g' | sed 's/\t/;/g')
        tee -a ${rel} <<< "$resp"
        echo "${CLEAN}"
    done < $names
    
    sed -i '/^$/d' ${rel}
    echo "
    ${INFORMATION}[Registros] Total de entradas consultadas:${CLEAN}${SUCCESS}${count}${CLEAN}
    "
}


# [X] Verificação de DS
# [ ] Consulta registros DNSKEY de um domínio e retorna os respectivos registros DS.

function treinalinuxDS() {
    echo "
    Consultando entradas DS
    "
    type='DS'
    names='Files/zones.txt'
    rel='Files/rel_all.csv'

    count=0

    while read name
    do
        count=$((count+1))
        echo "${count}) Resposta para ${name} do tipo: ${ATTENTION} "
        resp=$(dig @8.8.8.8 ${name} +noall +answer +noclass +ttlunits -t ${type} +qr | sed 's/\t\t/\t/g' | sed 's/\t/;/g')
        tee -a ${rel} <<< "$resp"
        echo "${CLEAN}"
    done < $names

    sed -i '/^$/d' ${rel}
    echo "
    ${INFORMATION}[DNSSEC] Total de entradas consultadas:${CLEAN}${SUCCESS}${count}${CLEAN}
    "
}


# treinalinuxInputs 'all'
treinalinuxInputs 'rd'
# treinalinuxInputs 'wo'
