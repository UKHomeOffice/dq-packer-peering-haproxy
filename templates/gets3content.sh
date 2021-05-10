#!/bin/sh
aws s3 cp s3://s3-dq-peering-haproxy-config-bucket-notprod/haproxy.cfg /etc/haproxy/haproxy.cfg --region eu-west-2
/etc/ssl/certs/make-dummy-cert /etc/ssl/certs/self-signed-cert
sudo haproxy -f /etc/haproxy/haproxy.cfg -p /var/run/haproxy.pid -sf $(cat /var/run/haproxy.pid)
