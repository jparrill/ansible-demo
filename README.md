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
- [Ansible Tower Subscription](https://www.ansible.com/tower-trial)

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
ansible_ssh_host: 192.168.1.51
ansible_ssh_pass: vagrant
ansible_ssh_port: 22
ansible_ssh_user: vagrant
```

- jboss02.localdomain
```
ansible_ssh_host: 192.168.1.52
ansible_ssh_pass: vagrant
ansible_ssh_port: 22
ansible_ssh_user: vagrant
```

- haproxy01.localdomain
```
ansible_ssh_host: 192.168.1.53
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

## Disconnected_mode
At first time, in your home, office or w/e you need to download all packages and software to perform the demo, the first time execute it in a connected environment to fulfill this requirements. Remember to download also the Plugins and Vagrant boxes.

To use the disconnected_mode just change you branch pointing to 'disconnected_mode' and execute this:

```
vagrant up jboss01.localdomain
....wait for it
vagrant ssh jboss01.localdomain
sudo su
bash /vagrant/utils/download_content.sh
```

Ensure that you have all rpms of haproxy, Jboss and the Jboss targz file in the disconnected folder. Now just logout from the VM.

Follow the demo from Pre-phase stage and don't change to master branch.

## Known Errors
If an error appears about the network waking up the VM, just change at Vagrantfile the network mode from
- node.vm.network :private_network, ip: details['address']

to
- node.vm.network "public_network", bridge: "en2: Wi-Fi (AirPort)"

Execute the download stage and change again to the first one network mode. Then wake up the VM's. Maybe will be necessary to destroy the 'jboss01.localdomain' vm before perform the changes at Vagrantfile

Error:
```
➜  ansible-demo git:(disconnected_mode) vagrant up jboss01.localdomain
Bringing machine 'jboss01.localdomain' up with 'virtualbox' provider...
==> jboss01.localdomain: Importing base box 'geerlingguy/centos7'...
==> jboss01.localdomain: Matching MAC address for NAT networking...
==> jboss01.localdomain: Checking if box 'geerlingguy/centos7' is up to date...
==> jboss01.localdomain: Setting the name of the VM: ansible-demo_jboss01localdomain_1460407294742_69126
==> jboss01.localdomain: Fixed port collision for 22 => 2222. Now on port 2200.
==> jboss01.localdomain: Clearing any previously set network interfaces...
The specified host network collides with a non-hostonly network!
This will cause your specified IP to be inaccessible. Please change
the IP or name of your host only network so that it no longer matches that of
a bridged or non-hostonly network.
```

## References
- [Ansible Doc](http://docs.ansible.com/ansible/index.html) - Ansible Official Documentation
- [Vagrant Doc](https://www.vagrantup.com/docs/) - Vagrant Official Documentation
- [Vagrant Atlas](https://atlas.hashicorp.com/boxes/search) - Vagrant Boxes
- [HAproxy](https://cbonte.github.io/haproxy-dconv/configuration-1.5.html) - HAproxy Documentation
- [Jboss Doc](https://access.redhat.com/documentation/es/jboss-enterprise-application-platform) - Jboss Documentation
- [ansible-examples](https://github.com/ansible/ansible-examples) - Demostration Roles and Playbooks
- [Questions and topics](doc/ansible_demo_notes.md) - Questions and concerns about Ansible, Tower and tips (thanks to our pal 'liquidat')

Enjoy!
