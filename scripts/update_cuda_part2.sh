#!/bin/bash
set -e

# installs cuda
if ! [ -f /etc/cuda_12.8.1_570.124.06_linux.run ]; then
  wget -O /etc/cuda_12.8.1_570.124.06_linux.run https://developer.download.nvidia.com/compute/cuda/12.8.1/local_installers/cuda_12.8.1_570.124.06_linux.run
fi
sh /etc/cuda_12.8.1_570.124.06_linux.run

# installs the container's toolkit
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
apt update -y
apt install -y nvidia-container-toolkit