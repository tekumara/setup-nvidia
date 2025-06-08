#!/usr/bin/env bash

set -euo pipefail

# install version 570.148.08
# 1083 MB of additional disk space will be used.
# Pin nvidia-persistenced because the latest version depends on libnvidia-cfg1
# which conflicts with nvidia-open-570 -> libnvidia-compute-570 -> libnvidia-cfg1-570
# Also pin nvidia-open-570 at the same time
apt-get install -y --no-install-recommends nvidia-persistenced=570.148.08-1ubuntu1 nvidia-open-570=570.148.08-1ubuntu1

# TODO: install nvidia persistence daemon?
# https://docs.nvidia.com/deploy/driver-persistence/index.html#persistence-daemon
