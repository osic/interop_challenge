********************************
OSIC Interoperability Challenge
********************************

This repository contain the details from environment creation to test case
execution for OSIC OpenStack Interoperability Challenge participation.

About the [OpenStack Interoperability Challenge](https://wiki.openstack.org/wiki/Interop_Challenge)

About the [Interops Working Group a.k.a. Defcore](https://wiki.openstack.org/wiki/Governance/DefCoreCommittee)

About [RefStack Tools](https://wiki.openstack.org/wiki/RefStack)


WORKLOADS
##########

LAMP Stack
**********

**Details:**

1. Tool: Ansible
2. Repo: https://github.com/openstack/osops-tools-contrib/ansible/lampstack
3. Flow: 

   * Start Ansible playbook from osops-tools-contrib/ansible/lampstack folder

      .. code-block:: bash
        
        ansible-playbook -e "action=apply env=osic password=XXXXX" site.yml

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


Docker Swarm
**********

**Details:**

1. Tool: Ansible
2. Repo: https://github.com/openstack/osops-tools-contrib/ansible/dockerswarm
3. Flow:
   * Start Ansible playbook from osops-tools-contrib/ansible/dockerswarm folder

     .. code-block:: bash
       
       ansible-playbook -e "action=apply env=osic username=XXXX password=YYYY project=ZZZZ" site.yml

   * Provision 3 coreos nodes on your cloud
   * Create security group
   * Add security rules to allow ping, ssh, docker access
   * Setup ssl keys, certificates
   * Display a set of environment variables that you can use to run docker commands


Deployer VM Pre-Requisites:
**********

One deployer to run them all -- Use a disposable VM to fire the workloads (cloud VM, vagrant, virtualbox).

1. [Install Ansible](http://docs.ansible.com/ansible/intro_installation.html)
2. [Install openstack shade] (http://docs.openstack.org/infra/shade/installation.html)
3. Make sure there are images available on your cloud:

    * An Ubuntu cloud image.
    * An OpenStack coreos image.
    
4. Clone osops repo
5. Create key-pair
6. Provide Cloud Details:

    * osops-tools-contrib/ansible/lampstack/vars/cloud1
    * osops-tools-contrib/ansible/dockerswarm/vars/cloud1

7. Install docker client

    * apt-get -y install docker.io
    * ln -sf /usr/bin/docker.io /usr/local/bin/docker

8. Disable strict host key checks:

    * Add "StrictHostKeyChecking no" to /etc/ssh/ssh_config under "Hosts *"

**NOTE:** Refer to the osops repo for further details.

**NOTE:** Use **deployer_novenv.sh** or **deployer_venv.sh** to install pre-reqs on your deployer VM (assume Ubuntu14.04)
