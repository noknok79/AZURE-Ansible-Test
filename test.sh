#!/bin/bash
echo "" > inventory.txt
az network public-ip list --query "[].{ResourceGroup: resourceGroup, Name: name, IP: ipAddress}" --output table >> inventory.txt
cat inventory.txt