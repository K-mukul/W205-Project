#!/bin/bash
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install ansible
sudo ansible-playbook -i "localhost," -c local /vagrant/datagather.yml
sudo supervisorctl update
