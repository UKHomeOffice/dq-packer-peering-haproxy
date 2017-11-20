#!/bin/sh
aws s3 cp s3://globalbucketname/haproxy.cfg /etc/haproxy/haproxy.cfg --region eu-west-2
haproxy -f /etc/haproxy/haproxy.cfg -p /var/run/haproxy.pid -st $(cat /var/run/haproxy.pid)
