# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.box_check_update = false

  config.vm.hostname = 'interopDeployer'
  config.vm.network :private_network, ip: '192.168.50.7'
  config.vm.provider "virtualbox" do |vb|
      vb.memory = 1024
  end
  config.vm.provision "shell", path: "deployer_novenv.sh", privileged: false
  config.vm.provision "shell", inline: "pip install -U six"
  config.vm.provision "shell", inline: "cp /vagrant/openrc.sh /home/vagrant", privileged: false
  config.vm.provision "shell", inline: 'sed -i -e "s/\/ubuntu/\/vagrant/g" /home/vagrant/osops-tools-contrib/ansible/lampstack/vars/osic.yml'
end
