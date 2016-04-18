#!/bin/bash
yum install -y java-1.7.0
rpm -Uvh http://repo.rundeck.org/latest.rpm
yum install -y rundeck net-tools
service rundeckd start
