#!/bin/bash

# Check if the script is running as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root" 
    exit 1
fi

# Install dependencies
apt-get update
apt-get install -y python3 python3-pip


# Install ansible and required packages
if [[ -f /etc/redhat-release ]]; then
    # CentOS
    yum install -y epel-release
    yum install -y ansible
elif [[ -f /etc/lsb-release ]]; then
    # Ubuntu
    pip3 install ansible[azure]
    ansible-galaxy collection install azure.azcollection
    pip3 install -r ~/.ansible/collections/ansible_collections/azure/azcollection/requirements-azure.txt
    pip3 install --upgrade packaging==20.9
    pip3 install --upgrade portalocker~=1.2
    apt-get install curl
    curl -sL https://aka.ms/InstallAzureCLIDeb | bash



    # pip3 install ansible msrestazure
    # pip3 install 'ansible[azure]'  
    # pip3 install --upgrade urllib3 chardet
    # pip3 install msal==1.24.0b2 
    # pip3 install azure-cli



    cat <<EOF > team.yml
- hosts: localhost
  connection: local
  collections:
    - azure.azcollection
  tasks:
    - name: Creating resource group
      azure_rm_resourcegroup:
    name: "team-ansible1-rg"
    location: "eastus"
EOF

    ansible-playbook team.yml
else
    echo "Unsupported OS distribution"
    exit 1
fi

# Verify Ansible installation
ansible --version



