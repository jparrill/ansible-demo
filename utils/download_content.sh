#!/bin/bash
## This script will download all necessary files to execute succesfully the disconnected_mode
## for this Demo. Follow the steps at README.md file

function download_jboss() {
  yum install -y --downloadonly --downloaddir=$jboss_fold unzip java-1.7.0-openjdk
  wget http://download.jboss.org/jbossas/7.1/jboss-as-7.1.1.Final/jboss-as-7.1.1.Final.zip -O /vagrant/disconnected/jboss-as-7.1.1.Final.zip
}

function download_haproxy() {
  yum install -y --downloadonly --downloaddir=$haproxy_fold socat haproxy
}

function requirements() {
  haproxy_fold=/vagrant/disconnected/haproxy/
  jboss_fold=/vagrant/disconnected/jboss/
  mkdir -p $haproxy_fold
  mkdir -p $jboss_fold
}

## Main
requirements
download_haproxy
download_jboss
