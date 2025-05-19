#!/bin/sh
set -x

echo " Remove node_exporter Container..."
sudo docker rm --force node_exporter

echo " Restarting Docker..."
sudo systemctl restart docker.service

echo " Run node_exporter Container..."
sudo docker run -d \
    --name node_exporter \
    --network host \
    -m 400M \
    --memory-swap 1G \
    --cpuset-cpus="0,1" \
    --restart always \
    -v "/:/host:ro,rslave" \
    --security-opt no-new-privileges:true \
    --cap-drop=ALL \
    --cap-add=CHOWN \
    --cap-add=SETUID \
    --read-only \
    --user 65534:65534 \
    --log-driver=json-file \
    --log-opt max-size=10m \
    --log-opt max-file=3 \
    --tmpfs /tmp:rw,noexec,nosuid,size=64M \
    quay.io/prometheus/node-exporter:latest \
    --path.rootfs=/host
