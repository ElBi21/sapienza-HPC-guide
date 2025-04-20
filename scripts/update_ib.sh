#!/bin/bash
set -e

for f in $( dpkg --list | grep -E 'doca|flexio|dpa-gdbserver|dpa-stats|dpaeumgmt' | awk '{print $2}' ); do echo $f ; apt remove --purge $f -y || true ; done
/usr/sbin/ofed_uninstall.sh --force || true
apt autoremove -y

wget -O /tmp/mlnx_signing_key_pub.der http://www.mellanox.com/downloads/ofed/mlnx_signing_key_pub.der 
mokutil --import /tmp/mlnx_signing_key_pub.der 

wget -O /tmp/doca-host_2.10.0-093000-25.01-ubuntu2404_amd64.deb https://www.mellanox.com/downloads/DOCA/DOCA_v2.10.0/host/doca-host_2.10.0-093000-25.01-ubuntu2404_amd64.deb
dpkg -i /tmp/doca-host_2.10.0-093000-25.01-ubuntu2404_amd64.deb 
apt update -y
apt --fix-broken -y install
apt upgrade -y

apt -y install doca-all
apt autoremove -y
reboot