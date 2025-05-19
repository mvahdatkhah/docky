#!/bin/sh
set -x
sudo docker rm --force ssl_exporter
sudo docker run -d \
    --name ssl_exporter \
    -p 9219:9219 \
    --net="host" \
    -m 400M \
    --memory-swap 1G \
    --cpuset-cpus="0,1" \
    --restart always \
    --pid="host" \
    -v "/:/host:ro,rslave" \
    ribbybibby/ssl-exporter:latest \
    --path.rootfs=/host
