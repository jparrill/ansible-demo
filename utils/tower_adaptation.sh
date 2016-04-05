#!/bin/bash
ln -s /vagrant /var/lib/awx/projects/ansible-demo
chown -h awx.awx /var/lib/awx/projects/ansible-demo
sed -i s/#host_key_checking/host_key_checking/ /etc/ansible/ansible.cfg
iptables -F
systemctl stop firewalld
ansible-tower-service restart
