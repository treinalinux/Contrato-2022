#!/bin/bash
# 
# Developer......: Alan da Silva Alves
# Name...........: Check Master Server
# Description....: Valid who node current of master server
# Version........: 0.1
# 
# ===========================================================================

query=$(dig ${MASTER} +noall +answer +noclass -t CNAME | xargs)
transfer_for="master-sp.empresa.corp"

# Script instaled on server master-rj.empresa.corp
transfer_for="master-sp.empresa.corp"

# entry valid
entry_valid=$(echo $query | cut -d" " -f 1)
# ttl valid
ttl=$(echo $query | cut -d" " -f 2)
# type valid
type_record=$(echo $query | cut -d" " -f 3)
# register record valid for check if i am master
node=$(echo $query | cut -d" " -f 4)

node_master=$(hostname -s)
node_master=$(echo ${node} | cut -d"." -f 1)

# ===========================================================================

# alert for changed on TTL
if [[ ${ttl} != 60 ]]; then
    echo "TTL atual ${ttl}: é um valor diferente do valor planejado, altere para 60."
fi

# alert for changed on type register DNS
if [[ ${type_record} != "CNAME" ]]; then
    echo "${type_record}: O tipo de registro foi alterado, isso não deveria ter acontecido. Corrigir para CNAME!"
fi

# if node current is master node, then transfer files for other node
if [[ ${node_local} == ${node_master} ]]; then
    echo "Sou o master ${node_master} ativo"
    sudo rsync -hiva /etc/ root@${transfer_for}:/etc/custom_src
else
    echo -e "Não sou master ativo, o master ativo é:\n${query}"
fi
