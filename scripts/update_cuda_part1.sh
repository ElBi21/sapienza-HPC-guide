#!/bin/bash
set -e

# removes previously installed cuda versions
rmmod nvidia_drm | rmmod nvidia_modeset | rmmod nvidia
sudo apt-get --purge -y remove "nvidia*" "libnvidia*"
sudo /usr/bin/nvidia-uninstall

# installs the drivers
if ! [ -f /etc/NVIDIA-Linux-x86_64-570.124.04.run ]; then
  wget -O /etc/NVIDIA-Linux-x86_64-570.124.04.run https://it.download.nvidia.com/XFree86/Linux-x86_64/570.124.04/NVIDIA-Linux-x86_64-570.124.04.run
fi
sh /etc/NVIDIA-Linux-x86_64-570.124.04.run