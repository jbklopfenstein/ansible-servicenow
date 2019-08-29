#!/usr/bin/env bash

sudo apt-get update
sudo apt-get install -y git

#Install your dependencies here. For example, to install python and pip:
# sudo apt-get install -y python-minimal
# curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
# python get-pip.py
# rm get-pip.py

#install/update bash
sudo apt-get install --only-upgrade bash

cd /home/vagrant/app
