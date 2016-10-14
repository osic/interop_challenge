Interoperability Challenge - OSIC Participation
===============================================

This repository contain the details from environment creation to test case
execution for OSIC OpenStack Interoperability Challenge participation.

About the [OpenStack Interoperability Challenge](https://wiki.openstack.org/wiki/Interop_Challenge)

About the [Interops Working Group a.k.a. Defcore](https://wiki.openstack.org/wiki/Governance/DefCoreCommittee)

About [RefStack Tools](https://wiki.openstack.org/wiki/RefStack)


THE WORKLOADS
---------

**LAMP Stack**
**********

**Details:**

1. Tool: Ansible
2. Repo: http://git.openstack.org/cgit/openstack/osops-tools-contrib/tree/ansible/lampstack
3. Start Ansible from osops-tools-contrib/ansible/lampstack folder

      ```
        ansible-playbook site.yml -e "action=apply env=osic username=$OS_USERNAME password=$OS_PASSWORD project=$OS_PROJECT_NAME"
       ```

4. Workload Creation Flow: 

   * Provision 4 nodes
   * Create security group
   * Add security rules to allow ping, ssh, mysql and nfs access
   * Create a cinder volume
   * Attach the cinder volume to database node for wordpress database and content
   * Setup NFS on database node, so that web servers can share the cinder
     volume space, all wordpress content will be saved on cinder volume.
     This is to ensure that the multiple web servers will represent same
     content.
   * Setup mysql to use the space provided by cinder volume
   * Configure and initialize wordpress
   * Install and activte a wordpress theme specified by configuration file
   * Install wordpress importer plugin
   * Import sample word press content
   * Remove not needed floating IPs from servers which do not need them.


**Docker Swarm**
**********

**Details:**

1. Tool: Ansible
2. Repo: http://git.openstack.org/cgit/openstack/osops-tools-contrib/tree/ansible/dockerswarm
3. Start Ansible from osops-tools-contrib/ansible/dockerswarm folder

      ```
        ansible-playbook site.yml -e "action=apply env=osic username=$OS_USERNAME password=$OS_PASSWORD project=$OS_PROJECT_NAME"
      ```

4. Workload Creation Flow: 
   * Provision 3 coreos nodes on your cloud
   * Create security group
   * Add security rules to allow ping, ssh, docker access
   * Setup ssl keys, certificates
   * Display a set of environment variables that you can use to run docker commands


**Deployer VM Pre-Requisites:**
**********

One deployer to run them all -- Use a disposable VM to fire the workloads (cloud VM, vagrant, virtualbox).

Use this repo to install required packages:

      ```
      # If disposable VM available, get deployer_novenv.sh or deployer_venv.sh
      wget https://raw.githubusercontent.com/osic/interops_challenge/master/deployer_novenv.sh
      ./deployer_novenv.sh
      
      # If using virtual box - Use our Vagrantfile
      git clone https://github.com/osic/interops_challenge.git
      cd interops_challenge
      vagrant up
      ```

1. Required Packages Installed by deployer_noenv.sh:
    * Install development packages
    * [Install Ansible](http://docs.ansible.com/ansible/intro_installation.html)
    * [Install openstack shade] (http://docs.openstack.org/infra/shade/installation.html)
    * Clone  http://git.openstack.org/cgit/openstack/osops-tools-contrib repo
    * Create key-pair
    * Create OSIC cloud1 Cloud Details:
       * osops-tools-contrib/ansible/lampstack/vars/cloud1
       * osops-tools-contrib/ansible/dockerswarm/vars/cloud1
    * Install docker client
        * apt-get -y install docker.io
        * ln -sf /usr/bin/docker.io /usr/local/bin/docker
    * Disable strict host key checks:
        * echo "StrictHostKeyChecking no" to /etc/ssh/ssh_config under "Hosts *"
    * [Install RefStack client](https://github.com/openstack/refstack-client)

2. Make sure there are images available on your cloud:
    * An Ubuntu cloud image.
    * An OpenStack coreos image.

**NOTE:** Refer to the osops-tools-contrib repo for further details.


RESULTS
--------

* Interops Challenge Results [email report](http://lists.openstack.org/pipermail/defcore-committee/2016-October/001286.html)
* RefStack Results:
    * [Against Defcore Guideline 2016.01](https://refstack.openstack.org/#/results/c66d2ded-7b26-4e0e-8efa-dbbcd5a1526b)
    * [Against Defcore Guideline 2016.08](https://refstack.openstack.org/#/results/a25bb6b0-82f7-4102-9eb0-dcb86b876cf8)

