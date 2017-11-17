#!/bin/bash
yum update -y
yum install gcc pcre-static pcre-devel openssl-devel zlib-devel wget -y
wget http://www.haproxy.org/download/1.7/src/haproxy-1.7.9.tar.gz
tar zxf haproxy-1.7.9.tar.gz
cd haproxy-1.7.9
make TARGET=linux2628 USE_PCRE=1 USE_OPENSSL=1 USE_ZLIB=1 USE_LIBCRYPT=1
make install
cp -R /usr/local/sbin/haproxy /usr/sbin/haproxy
cp -R examples/haproxy.init /etc/init.d/haproxy
chmod 755 /etc/init.d/haproxy
mkdir -p /etc/haproxy
touch /etc/haproxy/haproxy.cfg
mkdir -p /var/lib/haproxy
touch /var/lib/haproxy/stats
systemctl daemon-reload
useradd -r haproxy
chkconfig haproxy on
