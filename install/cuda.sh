#!/usr/bin/env bash

set -euo pipefail

set -x

## Equivalent to the nvidia/cuda:10.1-cudnn7-runtime-ubuntu18.04 docker image

## 10.1-base-ubuntu18.04
## see https://gitlab.com/nvidia/container-images/cuda/-/blob/master/dist/10.1/ubuntu18.04-x86_64/base/Dockerfile

CUDA_VERSION="10.1.243"
CUDA_PKG_VERSION="10-1=$CUDA_VERSION-1"

# For libraries in the cuda-compat-* package: https://docs.nvidia.com/cuda/eula/index.html#attachment-a
apt-get install -y --no-install-recommends \
    cuda-cudart-$CUDA_PKG_VERSION \
    cuda-compat-10-1 \
    && ln -s cuda-10.1 /usr/local/cuda10

## 10.1-runtime-ubuntu18.04
## see https://gitlab.com/nvidia/container-images/cuda/-/blob/master/dist/10.1/ubuntu18.04-x86_64/runtime/Dockerfile

NCCL_VERSION="2.7.8"

apt-get install -y --no-install-recommends \
    cuda-libraries-$CUDA_PKG_VERSION \
    cuda-npp-$CUDA_PKG_VERSION \
    cuda-nvtx-$CUDA_PKG_VERSION \
    libcublas10=10.2.1.243-1 \
    libnccl2=$NCCL_VERSION-1+cuda10.1 \
    && apt-mark hold libnccl2

# apt from auto upgrading the cublas package. See https://gitlab.com/nvidia/container-images/cuda/-/issues/88
apt-mark hold libcublas10

## 10.1-cudnn7-runtime-ubuntu18.04
## see https://gitlab.com/nvidia/container-images/cuda/-/blob/master/dist/10.1/ubuntu18.04-x86_64/runtime/cudnn7/Dockerfile

CUDNN_VERSION="7.6.5.32"

apt-get install -y --no-install-recommends \
    libcudnn7=$CUDNN_VERSION-1+cuda10.1 \
    && apt-mark hold libcudnn7
