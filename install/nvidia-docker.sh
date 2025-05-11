#!/usr/bin/env bash

set -euo pipefail

# see https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html

# install the Nvidia Container Toolkit to allow Docker to use GPUs
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
      && curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
      && curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
            sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
            tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
apt-get update

# we don't install nvidia-docker2 because it includes containerd, runc and docker.io (349MB)
# and we just want nvidia-container-toolkit (12.5MB)
apt-get install -y --no-install-recommends nvidia-container-toolkit

# configure
nvidia-ctk runtime configure --runtime=docker

if [[ $(pgrep docker) ]]; then
    RED='\033[0;31m'
    NC='\033[0m' # No Color
    echo -e "${RED}Restart the docker daemon for the nvidia container toolkit to take effect, eg: systemctl restart docker${NC}"
fi
