#!/bin/sh
set -x
sudo docker rm --force blackbox-exporter
sudo systemctl restart docker.service
mkdir /home/ansible/blackbox
cd /home/ansible/blackbox
cat <<EOF > blackbox.yml
modules:
  http_2xx:
    prober: http
    timeout: 5s
    http:
      method: GET
  ssl:
    prober: tcp
    timeout: 5s
    tcp:
      tls: true
      tls_config:
        insecure_skip_verify: false
EOF

sudo docker run -d \
    -m 400M \
    --memory-swap 1G \
    --cpuset-cpus="0,1" \
    --restart always \
    --name blackbox-exporter \
    -p 9115:9115 \
    -v /home/ansible/blackbox/blackbox.yml:/config/blackbox.yml:ro \
    --log-driver=json-file \
    --log-opt max-size=10m \
    --log-opt max-file=3 \
    --read-only \
    --tmpfs /tmp:rw,noexec,nosuid,size=64M \
    prom/blackbox-exporter:latest \
    --config.file=/config/blackbox.yml
