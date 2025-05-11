#!/usr/bin/env bash

set -euo pipefail

# install version 575.51.03
# 1033 MB of additional disk space will be used.
apt-get install -y --no-install-recommends nvidia-open-575

# TODO: install nvidia persistence daemon?
# https://docs.nvidia.com/deploy/driver-persistence/index.html#persistence-daemon
