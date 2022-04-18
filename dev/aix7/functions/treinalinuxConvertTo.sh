#!/bin/bash
#  ================================= Header =================================  #
#  
#  Name...............: treinalinuxConvertTo
#  Version............: 0.1
#  Description........: Convert To for inputs datas
#  Date...............: 04/18/2022
#  Create.............: Alan da Silva Alves
#  
#  ==========================================================================  #
#  ========================= Modules and Variables ==========================  #

source treinalinuxColorSchema.sh

ATTENTION=$(treinalinuxColorSchema ATTENTION)
CLEAN=$(treinalinuxColorSchema CLEAN)

#  =========================================================================  #
#  ================================= USAGE =================================  #

USAGE='

#!/bin/bash

# Load the functions:
source treinalinuxConvertTo.sh

# USAGE:

# Convert to text for uppercase
treinalinuxConvertToUpperCase "alan da silva alves"

# Convert to text for lowercasee
treinalinuxConvertToLowerCase "ALAN DA SILVA ALVES"

# Convert to file for uppercase
treinalinuxConvertToFile UP Files/my_list.txt

# Convert to text for lowercasee
treinalinuxConvertToFile LOW Files/my_list.txt

# Call this is help
treinalinuxConvertToUsage
'

#  =========================================================================  #
#  =============================== FUNCTIONS ===============================  #


function treinalinuxConvertToUsage() {
    echo "${ATTENTION}${USAGE} ${CLEAN}"
}

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
