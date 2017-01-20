# !/bin/bash

# set -o xtrace

sudo apt-get update
sudo apt-get install -y wget curl git
sudo apt-get install -y --force-yes build-essential libssl-dev libffi-dev python-dev libxml2-dev libxslt1-dev libpq-dev

sudo wget https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py
sudo rm get-pip.py

# Install docker client
sudo apt-get install -y docker.io
sudo ln -sf /usr/bin/docker.io /usr/local/bin/docker

# Install Ansible
sudo apt-get install -y software-properties-common
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get update
sudo apt-get install -y ansible

# Generate ssh keys
ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa

# Clone OSOPS TOOLS project
git clone https://github.com/openstack/osops-tools-contrib.git ~/osops-tools-contrib

# Install shade
sudo pip install shade

# Configure workloads
#echo "cloud ansible_python_interpreter=$python_interpreter/python" >> ~/osops-tools-contrib/ansible/lampstack/hosts
wget https://raw.githubusercontent.com/osic/interop_challenge/master/osic.lamp.yml -O ~/osops-tools-contrib/ansible/lampstack/vars/osic.yml
chmod +x ~/osops-tools-contrib/ansible/lampstack/vars/osic.yml
wget https://raw.githubusercontent.com/osic/interop_challenge/master/osic.swarm.yml -O ~/osops-tools-contrib/ansible/dockerswarm/vars/osic.yml
chmod +x ~/osops-tools-contrib/ansible/dockerswarm/vars/osic.yml

# Disable strict key check
sudo bash -c 'cat << EOF >> /etc/ssh/ssh_config
    StrictHostKeyChecking no
EOF'

# Install RefStack client
git clone https://github.com/openstack/refstack-client.git
cd refstack-client
./setup_env


