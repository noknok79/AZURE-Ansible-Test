#!/bin/bash

echo "Choose your cloud provider:"
echo "1. AWS"
echo "2. Azure"
read -p "Enter your choice (1 or 2): " choice

case $choice in

    1)
        
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$NAME
    elif type lsb_release >/dev/null 2>&1; then
        OS=$(lsb_release -si)
    else
        OS=$(uname -s)
    fi

    if [ "$OS" = "CentOS Linux" ]; then
        echo "CentOS detected"
        yum install language-pack-en -y
        curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp.gpg
        echo "deb [signed-by=/usr/share/keyrings/hashicorp.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
        yum update -y && yum  install terraform -y

        # Install Docker
        curl -fsSL https://get.docker.com -o get-docker.sh
        sh get-docker.sh
        # Enable Docker as a systemd service
        systemctl enable docker.service

        # Install Docker Compose
        curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        chmod +x /usr/local/bin/docker-compose

        # Install kubectl
        apt-get update && apt-get install -y apt-transport-https gnupg2 curl
        curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
        echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list
        yum  update && yum  install -y kubectl 

        # Install Ansible for Centos
        # CentOS
        yum install -y epel-release
        yum update -y
        yum install -y python3 python3-pip
        #yum install -y ansible
        pip3 install ansible[azure]
        ansible-galaxy collection install azure.azcollection
        pip3 install -r ~/.ansible/collections/ansible_collections/azure/azcollection/requirements-azure.txt
        pip3 install --upgrade packaging==20.9
        pip3 install --upgrade portalocker~=1.2
        yum install curl -y

        # Install AWS CLI for CentOS
        yum install -y awscli
        

            # Add CentOS-specific commands here
    elif [ "$OS" = "Ubuntu" ]; then
        echo "Ubuntu detected"
            
        # Install English language pack
        apt install language-pack-en -y

        # Install Terraform
        curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp.gpg
        echo "deb [signed-by=/usr/share/keyrings/hashicorp.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
        apt-get update -y && apt-get install terraform -y

        # Install Docker
        curl -fsSL https://get.docker.com -o get-docker.sh
        sh get-docker.sh
        # Enable Docker as a systemd service
        systemctl enable docker.service

        # Install Docker Compose
        curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        chmod +x /usr/local/bin/docker-compose

        # Install kubectl
        apt-get update -y && apt-get install -y apt-transport-https gnupg2 curl
        curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
        echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list
        apt-get update -y && apt-get install -y kubectl

        # Install bash-it

        # Install Ansible for Ubuntu
        # Ubuntu
        apt-get update
        apt-get install -y python3 python3-pip
        pip3 install ansible[azure]
        ansible-galaxy collection install azure.azcollection
        pip3 install -r ~/.ansible/collections/ansible_collections/azure/azcollection/requirements-azure.txt
        pip3 install --upgrade packaging==20.9
        pip3 install --upgrade portalocker~=1.2
        apt-get install curl
        curl -sL https://aka.ms/InstallAzureCLIDeb | bash
        # Add Ubuntu-specific commands here
    else
        echo "Unsupported OS. Exiting..."
        exit 1
    fi
        echo "Installing AWS CLI..."
        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
        unzip awscliv2.zip
        ./aws/install
        yum update -y; yum upgrade -y

        ;;
    2)
        
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$NAME
    elif type lsb_release >/dev/null 2>&1; then
        OS=$(lsb_release -si)
    else
        OS=$(uname -s)
    fi

    if [ "$OS" = "CentOS Linux" ]; then
        echo "CentOS detected"
        yum install language-pack-en -y
        curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp.gpg
        echo "deb [signed-by=/usr/share/keyrings/hashicorp.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
        yum update && yum  install terraform -y

        # Install Docker
        curl -fsSL https://get.docker.com -o get-docker.sh
        sh get-docker.sh
        # Enable Docker as a systemd service
        systemctl enable docker.service

        # Install Docker Compose
        curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        chmod +x /usr/local/bin/docker-compose

        # Install kubectl
        apt-get update && apt-get install -y apt-transport-https gnupg2 curl
        curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
        echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list
        yum  update && yum  install -y kubectl 

        # Install Ansible for Centos
        # CentOS
        yum install -y epel-release
        yum update -y
        yum install -y python3 python3-pip
        #yum install -y ansible
        pip3 install ansible[azure]
        ansible-galaxy collection install azure.azcollection
        pip3 install -r ~/.ansible/collections/ansible_collections/azure/azcollection/requirements-azure.txt
        pip3 install --upgrade packaging==20.9
        pip3 install --upgrade portalocker~=1.2
        yum install curl -y

        echo "Installing Azure CLI..."
        # Install Azure CLI for CentOS
        echo -e "[azure-cli]
        name=Azure CLI
        baseurl=https://packages.microsoft.com/yumrepos/azure-cli
        enabled=1
        gpgcheck=1
        gpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/azure-cli.repo
        yum update -y; yum upgrade -y

            # Add CentOS-specific commands here
    elif [ "$OS" = "Ubuntu" ]; then
        echo "Ubuntu detected"
            
        # Install English language pack
        apt install language-pack-en -y

        # Install Terraform
        curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp.gpg
        echo "deb [signed-by=/usr/share/keyrings/hashicorp.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
        apt-get update -y && apt-get install terraform -y

        # Install Docker
        curl -fsSL https://get.docker.com -o get-docker.sh
        sh get-docker.sh
        # Enable Docker as a systemd service
        systemctl enable docker.service

        # Install Docker Compose
        curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        chmod +x /usr/local/bin/docker-compose

        # Install kubectl
        apt-get update -y && apt-get install -y apt-transport-https gnupg2 curl
        curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
        echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list
        apt-get update -y && apt-get install -y kubectl

        # Install bash-it

        # Install Ansible for Ubuntu
        # Ubuntu
        apt-get update
        apt-get install -y python3 python3-pip
        pip3 install ansible[azure]
        ansible-galaxy collection install azure.azcollection
        pip3 install -r ~/.ansible/collections/ansible_collections/azure/azcollection/requirements-azure.txt
        pip3 install --upgrade packaging==20.9
        pip3 install --upgrade portalocker~=1.2
        apt-get install curl
        curl -sL https://aka.ms/InstallAzureCLIDeb | bash
        # Add Ubuntu-specific commands here
        echo "Installing Azure CLI..."
        curl -sL https://aka.ms/InstallAzureCLIDeb | bash
        apt update -y; apt upgrade -y
    else
        echo "Unsupported OS. Exiting..."
        exit 1
    fi
        echo "Installing Azure CLI..."
        curl -sL https://aka.ms/InstallAzureCLIDeb | bash
        apt update -y; apt upgrade -y
        ;;
    *)
        echo "Invalid choice. Exiting..."
        exit 1
        ;;



esac

echo "Installation completed successfully."


# # Install Terraform
# curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp.gpg
# echo "deb [signed-by=/usr/share/keyrings/hashicorp.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
# apt-get update && apt-get install terraform

# # Install Docker
# curl -fsSL https://get.docker.com -o get-docker.sh
# sh get-docker.sh
# # Enable Docker as a systemd service
# systemctl enable docker.service

# # Install Docker Compose
# curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# chmod +x /usr/local/bin/docker-compose

# # Install kubectl
# apt-get update && apt-get install -y apt-transport-https gnupg2 curl
# curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
# echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list
# apt-get update && apt-get install -y kubectl




# Install bash-it
git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
~/.bash_it/install.sh --silent


# Reload bash
source ~/.bashrc

echo "[boot]" >> /etc/wsl.conf
echo "systemd=true" >> /etc/wsl.conf

# Add comments
sed -i 's|^/root/.cargo/bin/subsystemctl start|# /root/.cargo/bin/subsystemctl start|' /root/.bash_profile
sed -i 's|^/root/.cargo/bin/subsystemctl exec bash|# /root/.cargo/bin/subsystemctl exec bash|' /root/.bash_profile
sed -i 's|^/urs/bin/neofetch|# /urs/bin/neofetch|#' /root/.bash_profile


# Add bash-it plugins (optional)
# bash-it enable plugin aws
# bash-it enable plugin docker
# bash-it enable plugin python
# bash-it enable plugin ssh
# bash-it enable plugin history
# bash-it enable plugin history-search
# bash-it enable plugin git

# Service Principal Installation
if [ $choice -eq 2 ]; then
    echo "Choose the service principal to install:"
    echo "1. win365ent"
    echo "2. ms365ent"
    echo "3. contoso"
    echo "4. markvilla"
    echo "5. nokiepersonal"
    read -p "Enter your choice (1, 2, or 3): " spChoice

    case $spChoice in
        1)
            echo "Installing win365ent service principal..."
            az login --service-principal -t cab4c3be-84af-48f5-960f-7415daff3a80 -u 1b88e6b9-1666-4eb0-9502-3b0bd6988557 -p LiQ8Q~~uCK4CtzCcH7Kww3BrD6LP48ap2FdrqcXP
            ;;
        2)
            echo "Installing ms365ent service principal..."
            az login --service-principal -t eff440af-7445-4a8f-8643-f9ba5523200c -u 6634af5b-abe0-441d-8943-6b69798ea8c7 -p z-s8Q~YHPBJnpMYwOkcdx7Qgv6FREMSDDrfN9drl

            ;;
        3)
            echo "Installing contoso service principal..."
            az login --service-principal -t 4a92cd4d-5cd3-4ef8-9154-c96cbd21a88c -u 751719d0-4786-4f07-9fb1-ceb97e65c9da -p qHV8Q~~nPyz3RZlen6IpMHhKgFthCZs_F57YCa37
            ;;
        4)
            echo "Installing markvilla service principal..."
            az login --service-principal -t ff742b2e-c0d5-40d6-ba63-b2107098b0dd -u b2fd2c7f-ece6-455b-9adf-a7da47796ba2 -p Zd-8Q~o2XfcY1vi08Xu2r-lEeQMI2SOzfBztdbVA
            ;;
        5)  
            echo "Installing nokiepersonal service principal..."
            az login --service-principal -t 3272c8d0-4e64-4fed-95a0-385c23b94a9f -u c2445908-a565-4661-99d4-21c9b944626a -p k.p8Q~M53PEKCqSu2tHnNB60aRO4KfshWXGItcLP
            ;;        
        *)
            echo "Invalid choice. Exiting..."
            exit 1
            ;;
    esac
fi
