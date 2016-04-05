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

## References
- [Ansible Doc](http://docs.ansible.com/ansible/index.html) - Ansible Official Documentation
- [Vagrant Doc](https://www.vagrantup.com/docs/) - Vagrant Official Documentation
- [Vagrant Atlas](https://atlas.hashicorp.com/boxes/search) - Vagrant Boxes
- [HAproxy](https://cbonte.github.io/haproxy-dconv/configuration-1.5.html) - HAproxy Documentation
- [Jboss Doc](https://access.redhat.com/documentation/es/jboss-enterprise-application-platform) - Jboss Documentation


Enjoy!
