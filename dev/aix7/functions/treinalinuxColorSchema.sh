#!/bin/bash
#  ================================= Header =================================  #
#  
#  Name...............: treinalinuxColorSchema
#  Version............: 0.1
#  Description........: Color schema of use on apps of terminal
#  Date...............: 04/14/2022
#  Update at..........: 04/17/2022
#                        - for and case for select color 
#  Create.............: Alan da Silva Alves
#  
#  =========================================================================  #
#  ================================= USAGE =================================  #

USAGE='

#!/bin/bash

# Load the function:
source treinalinuxColorSchema.sh

# Declare variables
SUCCESS=$(treinalinuxColorSchema SUCCESS)
DANGER=$(treinalinuxColorSchema DANGER)
INFORMATION=$(treinalinuxColorSchema INFORMATION)
CLEAN=$(treinalinuxColorSchema CLEAN)

# Use the variables
echo "${SUCCESS}Is my text green?${CLEAN} No color"
echo "${INFORMATION}!! Is my text cyan? !! ${CLEAN} No color"
echo " Is my text out of color?"
echo "${DANGER}Is my text red?${CLEAN}"
'

#  =========================================================================  #
#  =============================== FUNCTION ================================  #

function treinalinuxColorSchema() {
    ATTENTION='\033[1;93m'
    INFORMATION='\033[1;4;36;107m'
    SUCCESS='\033[92m'
    DANGER='\033[1;31m'
    CLEAN='\033[0m'

   case $1 in
       ATTENTION )
           echo -e "$ATTENTION $2"
           exit 0
           ;;
       INFORMATION )
           echo -e "$INFORMATION $2"
           exit 0
           ;;
       SUCCESS )
           echo -e "$SUCCESS $2"
           exit 0
           ;;
       DANGER)
           echo -e "$DANGER $2"
           exit 0
           ;;
       USAGE)
           echo "$USAGE"
           exit 0
           ;;
       *)
           echo -en "$CLEAN"
   esac
}
