#!/bin/bash
#  ============================== Header ==============================  #
#  
#  Name...............: treinalinuxColorSchema
#  Version............: 0.1
#  Description........: Color schema of use on apps
#  Date...............: 04/14/2022
#  Update at..........: 04/17/2022
#                        - for and case for select color 
#  Create.............: Alan da Silva Alves
#  
#  ============================== Header ==============================  #

USAGE='

# Load the function:
source treinalinuxColorSchema.sh

# Declare variables
SUCCESS=$(treinalinuxColorSchema SUCCESS)
DANGER=$(treinalinuxColorSchema DANGER)
CLEAN=$(treinalinuxColorSchema CLEAN)

# Use the variables
echo "${SUCCESS}Is my text green?${CLEAN} No color"
echo " Is my text out of color?"
echo "${DANGER}Is my text red?${CLEAN}"
'

function treinalinuxColorSchema() {
    ATTENTION='\033[1;93m'
    INFORMATION='\033[95m'
    SUCCESS='\033[92m'
    DANGER='\033[1;31m'
    CLEAN='\033[0m'
    for cor in ATTENTION INFORMATION SUCCESS DANGER USAGE
    do
        case $1 in
            ATTENTION )
                echo -e "$ATTENTION $2"
                break
                ;;
            INFORMATION )
                echo -e "$INFORMATION $2"
                break
                ;;
            SUCCESS )
                echo -e "$SUCCESS $2"
                break
                ;;
            DANGER)
                echo -e "$DANGER $2"
                break
                ;;
            USAGE)
                echo "$USAGE"
                break
                ;;
            *)
                echo -en "$CLEAN"
        esac
    done
}
