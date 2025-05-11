#!/usr/bin/env bash

set -euo pipefail

# install version 570.133.20
# 950 MB of additional disk space will be used.
apt-get install -y --no-install-recommends nvidia-open-570

# TODO: install nvidia persistence daemon?
# https://docs.nvidia.com/deploy/driver-persistence/index.html#persistence-daemon
