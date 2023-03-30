#!/bin/bash
# 
# Create by.....: Alan da Silva Alves
# Create at.....: 03/30/2023
# Name..........: fwcmd_rules
# Description...: Automation add rich rules firewall with firewall-cmd
# Version.......: 0.1
# .............................................................................
# .............................................................................

clear

echo ":::"
read -p "Informe a zona..............: [public]: " name_zone
read -p "Informe a famila de ips.........[ipv4]: " name_family
read -p "Informe o nome do servico...[rpc-bind]: " name_service
read -p "Informe o nome da acao .......[accept]: " name_action
read -p "[ENTER] para informar a lista de IPS..: " any_place
echo ":::"

# .............................................................................
# .............................................................................

FILE_IPS="${PWD}/IPS.txt"
echo > "${FILE_IPS}"
vim -c 'startinsert' "${FILE_IPS}"
list_ips=$(cat ${FILE_IPS})

echo ":::"

# .............................................................................
# .............................................................................

for IP in ${list_ips}
	do firewall-cmd --zone=$name_zone --add-rich-rule="rule family=$name_family source address=$IP service name=$name_service ${name_action}" --permanent
done

firewall-cmd --reload
firewall-cmd --list-rich-rules

echo ":::"
