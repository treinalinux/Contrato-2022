#!/bin/bash
#  ================================= Header =================================  #
#  
#  Name...............: treinalinuxRelDnsCompliance
#  Version............: 0.2
#  Description........: Report DNS compliance sla
#  Date...............: 04/19/2022
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
    read -p "[Enter] Informe as entradas que deseja consultar: " nada
    vim Files/domains.txt
}

function treinalinuxWhois() {
    echo "
    Consultando entradas whois
    "
    names='Files/domains.txt'
    rel='Files/rel_whois.txt'

    count=0

    while read name
    do
        count=$((count+1))
        echo "${count}) Resposta para ${name}:${ATTENTION} "
        whois ${name} >> ${rel}
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
    create_rel=$(echo "REGISTRO;TTL;TIPO;VALOR;DATA: ${log_date}" > 'Files/rel_rr.csv')
    rel='Files/rel_rr.csv'

    count=0

    while read name
    do
        count=$((count+1))
        echo "${count}) Resposta para ${name} do tipo ${type}: ${ATTENTION} "
        resp=$(dig @8.8.8.8 ${name} +noall +answer +noclass +ttlunits -t ${type} | sed 's/\t\t/\t/g' | sed 's/\t/;/g')
        tee -a ${rel} <<< "$resp"
        echo "${CLEAN}"
    done < $names

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
    names='Files/domains.txt'
    create_rel=$(echo "Name;Type" > 'Files/rel_ds.csv')
    rel='Files/rel_ds.csv'

    count=0

    while read name
    do
        count=$((count+1))
        echo "${count}) Resposta para ${name}: ${ATTENTION} "
        content=$(dig @8.8.8.8 ${name} DS +qr +short | xargs)
        tee -a ${rel} <<< "$name;$type;$content"
        echo "${CLEAN}"
    done < $names

    echo "
    ${INFORMATION}[DNSSEC] Total de entradas consultadas:${CLEAN}${SUCCESS}${count}${CLEAN}
    "
}


# treinalinuxWhois
treinalinuxInputs
treinalinuxRR
# treinalinuxDS
