# Ansible Demo
This Ansible demo contains some servers that will provide you an idea that really Ansible product works and also Tower.

Requirements:
- Libvirt/Virtualbox
- Vagrant
- Vagrant boxes:
  - centos7
  - Ansible-Tower
- Vagrant Plugins:
  - Vagrant-triggers
  - Vagrant-hostmanager
- Some Jboss Applications
- Rpms for disconnected environment

## Pre-Deployment
To prepare the environment to execute this demo you must execute some commands (we will asume that you already have installed Virtualbox and Vagrant or if you want to use Libvirt you also need vagrant-mutate plugin to convert Virtualbox boxes into Libvirt compatible image):

```
vagrant box add tower-2.4.3 http://vms.ansible.com/ansible-tower-2.4.3-virtualbox.box
vagrant box add geerlingguy/centos7
vagrant plugin install vagrant-hostmanager
vagrant plugin install vagrant-triggers
```

## Demo execution
This demo have manual part to show other ones how Tower works and how configure inventories, Job Templates and execute jobs and the automatic one that you will see how ansible works from console and how the changes are made.

### Pre-phase
Into repository root folder execute this:
```
vagrant up
vagrant ssh tower.localdomain
sudo su
bash /vagrant/utils/tower_adaptation.sh
```
**NOTE:** Copy the URL and Password to access Tower Server

Once inside of tower, go to 'Tools' image at top right corner and enter at Credentials menu, then create a new one with this details:
```
Name: vagrant
User that owns this credential: admin
Type: Machine
Username: vagrant
Password: vagrant
```

Submit the changes

### Inventory
When the nodes are up, get all the Ip's from everyone and create the inventory in Tower (Those ips are an example):
- Create the inventory file
- Create both groups
  - jboss-servers
  - lbservers
- Create all nodes in the the proper group

- jboss01.localdomain
```
ansible_ssh_host: 192.168.1.137
ansible_ssh_pass: vagrant
ansible_ssh_port: 22
ansible_ssh_user: vagrant
```

- jboss02.localdomain
```
ansible_ssh_host: 192.168.1.138
ansible_ssh_pass: vagrant
ansible_ssh_port: 22
ansible_ssh_user: vagrant
```

- haproxy01.localdomain
```
ansible_ssh_host: 192.168.1.139
ansible_ssh_pass: vagrant
ansible_ssh_port: 22
ansible_ssh_user: vagrant
```

### Project
Now is time to create the project into Tower:
- Go to Projects tab and press +
  - Use the name 'Ansible Demo'
  - Use SCM Type: Manual
  - Select 'ansible-demo' folder
- Submit the changes

### Jobs
Create a new Job Template:

- Deploy of a HAproxy server
```
Name: HAproxy Deployment
Job Type: Run
Inventory: vagrant
Project: Ansible Demo
Playbook: site.yml
Machine Credential: vagrant
Limit: lbservers
```

- Deploy of 2 JBoss servers
```
Name: JBoss Deployment
Job Type: Run
Inventory: vagrant
Project: Ansible Demo
Playbook: site.yml
Machine Credential: vagrant
Limit: jboss-servers
```

- Deployment with all service
```
Name: HA JBoss Deployment
Job Type: Run
Inventory: vagrant
Project: Ansible Demo
Playbook: site.yml
Machine Credential: vagrant
Limit: all
```

With all three templates created, now we can consume it ;), just press Run (rocket icon) and wait for it.

## References
- [Ansible Doc](http://docs.ansible.com/ansible/index.html) - Ansible Official Documentation
- [Vagrant Doc](https://www.vagrantup.com/docs/) - Vagrant Official Documentation
- [Vagrant Atlas](https://atlas.hashicorp.com/boxes/search) - Vagrant Boxes
- [HAproxy](https://cbonte.github.io/haproxy-dconv/configuration-1.5.html) - HAproxy Documentation
- [Jboss Doc](https://access.redhat.com/documentation/es/jboss-enterprise-application-platform) - Jboss Documentation


Enjoy!
