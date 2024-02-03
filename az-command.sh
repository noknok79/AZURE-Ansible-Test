#!/bin/bash

az network public-ip list --query '[].ipAddress' --output tsv >> inventory.txt

az vm list --query "[].{Name:name, PublicIP:publicIps[0], OS:storageProfile.osDisk.osType, Offer:storageProfile.imageReference.offer}" --output table >> inventory.txt

