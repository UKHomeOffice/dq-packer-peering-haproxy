# dq-packer-peering-haproxy
This repository creates an AMI in AWS with HAProxy with logging to rsyslog

## `packer.json`
This file contains a wrap up for Ansible script to be run inside small RedHat 7.5 machine

## `playbook.yml`
Ansible playbook installing the following:
- rsyslog
- HAProxy v.1.7.11 - installed from source and compiled locally wih the follwing options:
    - TARGET: linux2628
    - USE_PCRE: 1
    - USE_OPENSSL: 1
    - USE_ZLIB: 1
    - USE_LIBCRYPT: 1

    More information can be found [here](https://github.com/joyent/haproxy-1.8/blob/master/Makefile)

## `templates`

#### `gets3content.sh`
This file is copied to `/home/ec2-user` and cron entry created to run it every minute

#### `rsyslog.conf.j2`
Initial rsyslog main configuration

#### `49-haproxy.conf.j2`
Initial rsyslog config to capture logs from HAProxy

#### `haproxy.cfg`
HAProxy initial configuration. It contains TCP frontend (23) which is used for testing if proxy is up.
if you plan to change it, update `playbook.yml` accordingly
