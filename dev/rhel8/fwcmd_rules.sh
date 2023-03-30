#!/bin/bash
# 
# Create by.....: Alan da Silva Alves
# Create at.....: 03/30/2023
# Name..........: fwcmd_rules
# Description...: Automation add rich rules firewall with firewall-cmd
# Version.......: 0.2
# Updates.......: 
#                 Conversion to functions
#                 Validates action_roles
# .............................................................................
# .............................................................................

clear

echo ":::"
read -p "Vai adicionar ou remover regras..[a/r]: " action_roles
read -p "Informe a zona..............: [public]: " name_zone
read -p "Informe a famila de ips.........[ipv4]: " name_family
read -p "Informe o nome do serviço...[rpc-bind]: " name_service
read -p "Informe o nome da ação .......[accept]: " name_action
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

function reload_new_rules(){
	sudo firewall-cmd --reload
	sudo firewall-cmd --list-rich-rules
	echo ":::"
}


function add_rich_rule_service(){
	for ip in ${list_ips}
		do sudo firewall-cmd --zone=${name_zone} --add-rich-rule="rule family=${name_family} source address=${ip} service name=${name_service} ${name_action}" --permanent
	done
	reload_new_rules
}


function remove_rich_rule_service(){
	for ip in ${list_ips}
		do sudo firewall-cmd --zone=${name_zone} --remove-rich-rule="rule family=${name_family} source address=${ip} service name=${name_service} ${name_action}" --permanent
	done
	reload_new_rules
}

if [[ ${action_roles} == 'a' ]] || [[ ${action_roles} == 'A' ]]; then
	add_rich_rule_service
elif [[ ${action_roles} == 'r' ]] || [[ ${action_roles} == 'R' ]]; then
	remove_rich_rule_service
else
	echo "Ação inválida, necessário informar uma ação para a role!"
	echo ":::"
	exit 1
fi
