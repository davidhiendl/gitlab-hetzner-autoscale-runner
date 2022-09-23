#!/bin/bash

echo "Starting Hetzner Ubuntu 22.04 optimized fast docker install ..."

# pin docker to 19.03*
#sudo tee /etc/apt/preferences.d/200_docker-ce > /dev/null <<EOT
#Package: docker-ce*
#Pin: version 5:19.03*
#Pin-Priority: 1001
#EOT

mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
 
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io

echo "Finished Hetzner Ubuntu 22.04 optimized fast docker install"
