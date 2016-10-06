# !/bin/bash

# set -o xtrace

sudo apt-get update
sudo apt-get install -y wget curl git
sudo apt-get install -y --force-yes build-essential libssl-dev libffi-dev python-dev libxml2-dev libxslt1-dev libpq-dev

sudo wget https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py

sudo pip install virtualenv

# Install docker client
sudo apt-get install -y docker.io
sudo ln -sf /usr/bin/docker.io /usr/local/bin/docker

# Generate ssh keys
ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa

# Clone OSOPS TOOLS project
git clone https://github.com/openstack/osops-tools-contrib.git ~/osops-tools-contrib

# Create virtual environment .interops
virtualenv .interops
python_interpreter=.interops/bin

# Install ansible on the venv
$python_interpreter/pip install ansible==2.1.2.0
# Install shade on the venv
$python_interpreter/pip install shade==1.12.1

# Configure Workloads -- Comment since added in osops repo
#echo "cloud ansible_python_interpreter=$python_interpreter/python" >> ~/osops-tools-contrib/ansible/lampstack/hosts
#echo "cloud ansible_python_interpreter=$python_interpreter/python" >> ~/osops-tools-contrib/ansible/dockerswarm/hosts
wget https://raw.githubusercontent.com/osic/interops_challenge/master/osic.lamp.yml -O ~/osops-tools-contrib/ansible/lampstack/vars/osic.yml
chmod +x ~/osops-tools-contrib/ansible/lampstack/vars/osic.yml
wget https://raw.githubusercontent.com/osic/interops_challenge/master/osic.swarm.yml -O ~/osops-tools-contrib/ansible/dockerswarm/vars/osic.yml
chmod +x ~/osops-tools-contrib/ansible/dockerswarm/vars/osic.yml

# Disable strict key check -- Comment since added in osops via ansible.cfg
#sudo bash -c 'cat << EOF >> /etc/ssh/ssh_config
#    StrictHostKeyChecking no
#EOF'

echo "========================================"
echo "Activate virtual environment by running:"
echo "     source .interops/bin/activate"
echo "========================================"
