#!/bin/bash
# 
# Create by.....: Alan da Silva Alves
# Create at.....: 03/30/2023
# Name..........: fwcmd_rules
# Description...: Automation add rich rules firewall with firewall-cmd
# Version.......: 0.3
# Updates.......: 
#                 Conversion to functions
#                 Validates action_roles
#                 Adicionar por porta
#                 Remover por porta
#
# .............................................................................
# .............................................................................

#clear

echo ":::"
read -p "Vai adicionar ou remover regras..[a/r]: " action_roles
read -p "Informe a zona..............: [public]: " name_zone
read -p "Informe a famila de ips.........[ipv4]: " name_family
read -p "Informe serviço ou porta.........[s/p]: " name_type
if [[ ${name_type} == 's' ]] || [[ ${name_type} == 'S' ]]; then
	read -p "Informe o nome do serviço...[rpc-bind]: " name_service
else
	read -p "Informe o número da porta.........[22]: " name_port
	read -p "Informe o nome do protocolo..[tcp/udp]: " name_protocol
fi
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


function add_rich_rule_port(){
	for ip in ${list_ips}
		do sudo firewall-cmd --zone=${name_zone} --add-rich-rule="rule family=${name_family} source address=${ip} port port=${name_port} protocol=$name_protocol ${name_action}" --permanent
	done
	reload_new_rules
}

function remove_rich_rule_service(){
	for ip in ${list_ips}
		do sudo firewall-cmd --zone=${name_zone} --remove-rich-rule="rule family=${name_family} source address=${ip} service name=${name_service} ${name_action}" --permanent
	done
	reload_new_rules
}

function remove_rich_rule_port(){
	for ip in ${list_ips}
		do sudo firewall-cmd --zone=${name_zone} --remove-rich-rule="rule family=${name_family} source address=${ip} port port=${name_port} protocol=$name_protocol ${name_action}" --permanent
	done
	reload_new_rules
}

if [[ ${action_roles} == 'a' ]] || [[ ${action_roles} == 'A' ]]; then
	if [[ ${name_type} == 's' ]] || [[ ${name_type} == 'S' ]]; then
		echo "Adicionando o ${name_service}!"
		add_rich_rule_service
	else
		echo "Adicionando a porta ${name_port} para o protocolo ${name_protocol}!"
		add_rich_rule_port
	fi
elif [[ ${action_roles} == 'r' ]] || [[ ${action_roles} == 'R' ]]; then
	if [[ ${name_type} == 's' ]] || [[ ${name_type} == 'S' ]]; then
		echo "Removendo o ${name_service}!"
		remove_rich_rule_service
	else
		echo "Removendo a porta ${name_port} para o protocolo ${name_protocol}!"
		remove_rich_rule_port
	fi
else
	echo "Ação inválida, necessário informar uma ação para a role!"
	echo ":::"
	exit 1
fi
