#!/bin/bash

echo "installscript: waiting (only) for docker ..."

while sleep 1; do
    if [ -e /etc/systemd/system/docker.service.d/10-machine.conf ]; then
        sleep 15
        systemctl restart docker
        break
    fi
done &
