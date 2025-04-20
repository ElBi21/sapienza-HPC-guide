#!/bin/bash
set -e

# downloads and extracts OpenMPI
cd /tmp
wget -O openmpi-5.0.7.tar.bz2 https://download.open-mpi.org/release/open-mpi/v5.0/openmpi-5.0.7.tar.bz2
tar xf openmpi-5.0.7.tar.bz2

# installs OpenMPI
cd openmpi-5.0.7
./configure --prefix=/usr/local --with-slurm
make -j 8 all install

# cleans the directory
cd /tmp
rm -rf openmpi-*

# installs post-requisites
apt update -y
apt upgrade -y
apt install openmpi-bin
apt install --reinstall -y hcoll ucx
ompi_info