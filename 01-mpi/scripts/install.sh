#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

sudo apt-get update -y
sudo apt-get install -y \
    build-essential \
    cmake \
    g++ \
    libmpich-dev \
    libomp-dev \
    libboost-all-dev \
    mpich \
    nfs-common \
    nfs-kernel-server \
    openssh-server

# configure nfs server
mkdir -p /home/vagrant/.shared
sudo chown -R vagrant:vagrant /home/vagrant/.shared
echo "/home/vagrant/.shared *(rw,sync,no_subtree_check)" | sudo tee -a /etc/exports
sudo exportfs -a

# configure ssh server
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
sudo chmod 600 /home/vagrant/.ssh/id_rsa
sudo chmod 644 /home/vagrant/.ssh/id_rsa.pub
sudo chmod 644 /home/vagrant/.ssh/config
sudo chmod 644 /home/vagrant/.ssh/authorized_keys
