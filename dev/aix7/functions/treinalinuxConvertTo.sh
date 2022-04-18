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

treinalinuxConvertTo UP Alan
treinalinuxConvertTo LOW ALAN
'

#  =========================================================================  #
#  =============================== FUNCTION ================================  #

function treinalinuxConvertTo() {
    UPPERCASE=$(echo $2 | tr '[:lower:]' '[:upper:]')
    LOWERCASE=$(echo "$2" | tr '[:upper:]' '[:lower:]')
    
    case $1 in
       UP )
           echo "$UPPERCASE"
           ;;
       LOW )
           echo "$LOWERCASE"
           ;;
       USAGE)
           echo "$USAGE"
           ;;
       *)
           echo "How to: USAGE"
   esac
}

# treinalinuxConvertTo UP 'Alan da Silva Alves'
