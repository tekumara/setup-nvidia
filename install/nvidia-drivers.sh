#!/usr/bin/env bash

set -euo pipefail

# see https://docs.nvidia.com/datacenter/tesla/drivers/index.html#package-managers

# add nvidia repos
apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub && \
echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64 /" > /etc/apt/sources.list.d/cuda.list && \
apt-get update

# install nvidia kernel module, libnvidia-* etc. (1728 MB)
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends cuda-drivers

# TODO: install nvidia persistence daemon?
# https://docs.nvidia.com/deploy/driver-persistence/index.html#persistence-daemon
