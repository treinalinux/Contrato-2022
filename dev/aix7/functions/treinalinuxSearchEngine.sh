#!/bin/bash
#  ============================== Header ==============================  #
#  
#  Name...............: treinalinuxSearchEngine
#  Version............: 0.1
#  Description........: Find with an list on file and salve result
#  Date...............: 04/15/2022
#  Create.............: Alan da Silva Alves
#  
#  ============================== Header ==============================  #

function treinalinuxSearchEngine() {
    read -p "[Enter] Informe a lista que deseja buscar: " nada
    vim "$PWD/Files/my_list.txt"
    my_list="$PWD/Files/my_list.txt"
    read -p "Informe o caminho do arquivo que onde buscar: " my_file
    my_result="$PWD/Files/resultado.txt"

    my_find=$(grep -f "$my_list" "$my_file" > "$my_result")

    if [[ -s "$my_result" ]]; then
        echo "Sucesso"
    else
        echo "Sem resultados para sua busca no arquivo $my_file"
    fi
}
