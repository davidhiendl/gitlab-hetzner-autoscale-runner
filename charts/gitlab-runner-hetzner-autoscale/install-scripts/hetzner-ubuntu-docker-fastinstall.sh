#!/bin/bash

echo "Starting Hetzner Ubuntu 20.04 optimized fast docker install ..."

# pin docker to 19.03*
sudo tee /etc/apt/preferences.d/200_docker-ce > /dev/null <<EOT
Package: docker-ce*
Pin: version 5:19.03*
Pin-Priority: 1001
EOT

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io

echo "Finished Hetzner Ubuntu 20.04 optimized fast docker install"
