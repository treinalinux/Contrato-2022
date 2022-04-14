#!/bin/bash
#  ============================== Header ==============================  #
#  
#  Name...............: addUserNetgroup
#  Version............: 0.1
#  Description........: Create new netgroup or add users on netgroups.
#  Date...............: 04/14/2022
#  Create.............: Alan da Silva Alves
#  
#  ============================== Header ==============================  #

## Starting the APP

## Declaration of variables

### Color Function

### Clear variables (count, operation, netgroup, host/user, logs, locality, register)

## Receives input with name of netgroup

## Get the transaction information (Create or Add)

## Test if netgroup exists

### If the netgroup exists with operation type Create, then enter show and exit the app

### If the netgroup exists with operation type Add, then proceed to add hosts/users on netgroup

### If the netgroup does not exist, then proceed to create netgroup

## Receives input from administrator

### Handles the data received by the administrator

### Declaration of variables

## Create netgroup

### Check for errors creating netgroup

#### Salve logs errors netgroup

#### Show logs errors netgroup

### Create netgroup with news hosts/users

### Salve logs of new netgroup

#### Show logs netgroup

## Update secondary servers, necessary case

## End APP

