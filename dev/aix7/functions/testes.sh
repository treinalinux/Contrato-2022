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

