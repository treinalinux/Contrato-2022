#!/bin/bash
#  ================================= Header =================================  #
#  
#  Name...............: treinalinuxConvertTo
#  Version............: 0.1
#  Description........: Convert To for inputs datas
#  Date...............: 04/18/2022
#  Create.............: Alan da Silva Alves
#  
#  =========================================================================  #
#  ================================= USAGE =================================  #

USAGE='

#!/bin/bash

# Load the function:
source treinalinuxConvertTo.sh


treinalinuxConvertToUpperCase "Alan da Silva Alves"
treinalinuxConvertToLowerCase "Alan da Silva Alves"
treinalinuxConvertToFile UP Files/my_list.txt
treinalinuxConvertToFile LOW Files/my_list.txt
'

#  =========================================================================  #
#  =============================== FUNCTIONS ===============================  #

function treinalinuxConvertToUpperCase() {
    UPPERCASE=$(echo "$1" | tr '[:lower:]' '[:upper:]')
    echo "$UPPERCASE"
}


function treinalinuxConvertToLowerCase() {
    LOWERCASE=$(echo "$1" | tr '[:upper:]' '[:lower:]')
    echo "$LOWERCASE"
}


function treinalinuxConvertToFile() {
    while read line
    do
        if [[ "$1" = 'UP' ]]
        then
            echo "$line" | tr '[:lower:]' '[:upper:]'
        elif [[ "$1" = 'LOW' ]]
        then
            echo "$line" | tr '[:upper:]' '[:lower:]'
        fi
    done < <(cat "$2")
}
