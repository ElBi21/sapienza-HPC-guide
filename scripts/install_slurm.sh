#!/bin/bash
set -e

# arguments parsing
if [[ ! $# == 1 ]] ; then
    echo "You have to supply exactly one argument"
    exit 1
fi

NODE_TYPE=$1

case "$NODE_TYPE" in
    controller|compute|login|db)
        echo "Setting up a $NODE_TYPE node"
        ;;
    *)
        echo "Invalid option. Please enter one of: controller, compute, login, db."
        exit 1
        ;;
esac

# uninstall previous slurm versions and install pre-requisites
apt install -y build-essential fakeroot devscripts equivs

# download slurm
cd /tmp
if [ -d slurm-24.11.1 ]; then
  echo "Removing /tmp/slurm-24.11.1 directory to perform a clean installation"
  rm -rf slurm-24.11.1
fi
wget -O slurm-24.11.1.tar.bz2 https://download.schedmd.com/slurm/slurm-24.11.1.tar.bz2
tar -xaf slurm-24.11.1.tar.bz2

# install slurm
cd slurm-24.11.1
mk-build-deps -i debian/control
debuild -b -uc -us
mkdir /var/slurmproc || true

# install the packages based on the type of node
cd ..
dpkg -i slurm-smd_24.11.1-1_amd64.deb
case "$NODE_TYPE" in
    controller)
        sudo dpkg -i slurm-smd-client_24.11.1-1_amd64.deb slurm-smd-slurmctld_24.11.1-1_amd64.deb
        ;;
    compute)
        sudo dpkg -i slurm-smd-client_24.11.1-1_amd64.deb slurm-smd-slurmd_24.11.1-1_amd64.deb
        ;;
    login)
        sudo dpkg -i slurm-smd-client_24.11.1-1_amd64.deb
        ;;
    db)
        sudo dpkg -i slurm-smd-slurmdbd_24.11.1-1_amd64.deb
        ;;
esac
echo "SLURM has been installed successfully"

# removes trash
rm -rf /tmp/slurm*