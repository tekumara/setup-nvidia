#!/usr/bin/env bash

set -euo pipefail

# add nvidia repos
curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub | apt-key add - && \
echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/cuda.list && \
echo "deb https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list
apt-get update

# install nvidia kernel module
apt-get install -y --no-install-recommends cuda-drivers

# TODO: install nvidia persistence daemon?
# https://docs.nvidia.com/deploy/driver-persistence/index.html#persistence-daemon
