#!/bin/bash
echo "" > inventory.txt
az network public-ip list --query '[].ipAddress' --output tsv | while read -r ip; do
    echo "ansible_host=$ip ansible_user=azureuser ansible_ssh_private_key_file=/home/azureuser/.ssh/authorized_keys/id_rsa" >> inventory.txt
done
sed -i 's/ansible_host=//g' inventory.txt
cat inventory.txt