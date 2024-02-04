#!/bin/bash

        echo "You chose Azure"
        # Add your Azure code here
        if [[ -f /etc/os-release ]]; then
            source /etc/os-release
            if [[ $ID == "centos" ]]; then
                echo "CentOS detected"
                if [[ -f /etc/apt/sources.list.d/hashicorp.list ]]; then
                    rm /etc/apt/sources.list.d/hashicorp.list
                fi
                #Install Terraform
                yum update -y; yum upgrade  -y
                yum install language-pack-en curl gpg -y
                yum install  yum-utils -y
                yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
                yum -y install terraform


                # Install Docker
                curl -fsSL https://get.docker.com -o get-docker.sh
                sh get-docker.sh
                # Enable Docker as a systemd service
                systemctl enable docker.service
                systemctl start docker.service

                # Install Docker Compose
                curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
                chmod +x /usr/local/bin/docker-compose

                # Install kubectl
                yum update -y && yum install -y gnupg2 curl
                curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
                install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

                # Install Ansible for Centos
                # CentOS
                yum install epel-release -y
                yum install ansible -y

                # Install Azure CLI
                yum install curl -y
                # echo -e "[azure-cli] \
                # name=Azure CLI \
                # baseurl=https://packages.microsoft.com/yumrepos/azure-cli 
                # enabled=1 
                # gpgcheck=1 
                # gpgkey=https://packages.microsoft.com/keys/microsoft.asc" | tee /etc/yum.repos.d/azure-cli.repo
                # yum install azure-cli -y
                # Add your CentOS code here
            elif [[ $ID == "ubuntu" ]]; then
                echo "Ubuntu detected"
                if [[ -f /etc/apt/sources.list.d/hashicorp.list ]]; then
                    rm /etc/apt/sources.list.d/hashicorp.list
                fi
                apt update -y; apt upgrade -y
                apt install language-pack-en curl gpg apt python3 python3-pip -y
                
                #Install Terraform
                apt update && apt  install -y gnupg software-properties-common curl && curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - && apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && apt-get update && apt-get install terraform 

                # Install Docker
                curl -fsSL https://get.docker.com -o get-docker.sh
                sh get-docker.sh
                # Enable Docker as a systemd service
                systemctl enable docker.service
                systemctl start docker.service

                # Install Docker Compose
                curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
                chmod +x /usr/local/bin/docker-compose

                # Install kubectl
                apt update -y && apt install -y apt-transport-https gnupg2 curl
                curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
                echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list
                apt update -y && apt install -y kubectl

                # Install bash-it

                # Install Ansible for Ubuntu
                # Ubuntu
                apt update -y
                apt install python3-pip -y
                pip3 install ansible[azure]
                ansible-galaxy collection install azure.azcollection
                pip3 install -r ~/.ansible/collections/ansible_collections/azure/azcollection/requirements-azure.txt
                pip3 install --upgrade packaging==20.9
                pip3 install --upgrade portalocker~=1.2
                apt install curl
                curl -sL https://aka.ms/InstallAzureCLIDeb | bash
                # Add your Ubuntu code here
            else
                echo "Unsupported OS"
            fi
        else
            echo "Unable to detect OS"
        fi