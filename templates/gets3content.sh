#!/bin/sh
aws s3 cp s3://globalbucketname/haproxy.cfg /etc/haproxy/haproxy.cfg --region eu-west-2
service haproxy reload
