#!/usr/bin/env bash

set -euo pipefail

# add nvidia repo, eg: https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64
case "$(uname -m)" in
    "aarch64") arch="sbsa" ;;
    "x86_64") arch="x86_64" ;;
    *) echo "error: unknown arch $(uname -m)" && exit 42 ;;
esac

ubuntu_version=22.04
curl -fsSLo cuda-keyring_1.1-1_all.deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu${ubuntu_version//./}/${arch}/cuda-keyring_1.1-1_all.deb
dpkg -i cuda-keyring_1.1-1_all.deb
rm cuda-keyring_1.1-1_all.deb
apt-get update
