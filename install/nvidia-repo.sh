#!/usr/bin/env bash

set -euo pipefail

# gnupg2 needed to add third party repos
# curl is used in later scripts
apt-get update && apt-get install -y --no-install-recommends gnupg2 curl ca-certificates

# add nvidia repo
apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub && \
echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64 /" > /etc/apt/sources.list.d/cuda.list && \
apt-get update
