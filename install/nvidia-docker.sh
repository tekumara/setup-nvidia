#!/usr/bin/env bash

set -euo pipefail

RED='\033[0;31m'
NC='\033[0m' # No Color

# install the Nvidia Container Toolkit to allow Docker to use GPUs
curl -fsSL https://nvidia.github.io/nvidia-docker/gpgkey | apt-key add -
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | tee /etc/apt/sources.list.d/nvidia-docker.list
apt-get update

apt-get install -y --no-install-recommends nvidia-container-toolkit

# NB: if docker is running, you'll need to restart it: systemctl restart docker
if [[ $(pgrep docker) ]]; then
    echo -e "${RED}Restart the docker daemon for the nvidia container toolkit to take effect, eg: systemctl restart docker${NC}"
fi
