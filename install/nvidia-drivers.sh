#!/usr/bin/env bash

set -euo pipefail

# install version 570.133.20
# 950 MB of additional disk space will be used.
# TODO: try --no-install-recommends
sudo apt-get install -y nvidia-open-570

# TODO: install nvidia persistence daemon?
# https://docs.nvidia.com/deploy/driver-persistence/index.html#persistence-daemon
