#!/usr/bin/env bash

set -euo pipefail

# see https://docs.nvidia.com/datacenter/tesla/drivers/index.html#package-managers

# install nvidia kernel module, libnvidia-* etc. (1558 MB)
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends cuda-drivers

# TODO: install nvidia persistence daemon?
# https://docs.nvidia.com/deploy/driver-persistence/index.html#persistence-daemon
