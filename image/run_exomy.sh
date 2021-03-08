#!/bin/bash
wpa_cli -i wlan0 set country ES
wpa_cli -i wlan0 save_config
rfkill unblock wifi
service networking restart
systemctl restart 

# Load container
gzip -d exomy.tar.gz
docker load < exomy.tar

# Run docker container
docker run \
    -p 8000:8000 \
    -p 8080:8080 \
    -p 9090:9090 \
    --privileged \
    --restart always \
    --name exomy \
    exomy