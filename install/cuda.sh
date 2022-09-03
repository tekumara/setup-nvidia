#!/usr/bin/env bash

set -euo pipefail

set -x

# Equivalent to the nvidia/cuda:11.2.2-cudnn8-runtime-ubuntu20.04 docker image
# See list of libraries here https://docs.nvidia.com/cuda/eula/index.html#attachment-a

# 11.2.2-base-ubuntu20.04
# see https://gitlab.com/nvidia/container-images/cuda/-/blob/master/dist/11.2.2/ubuntu2004/base/Dockerfile

CUDA_VERSION="11-2"
CUDA_PKG_VERSION="11.2.152-1"
CUDA_LIB_VERSION="11.2.2-1"

# 30 MB
apt-get install -y --no-install-recommends \
    cuda-cudart-$CUDA_VERSION=$CUDA_PKG_VERSION \
    cuda-compat-$CUDA_VERSION \
    && ln -s cuda-11.2 /usr/local/cuda

# 11.2.2-runtime-ubuntu20.04
# see https://gitlab.com/nvidia/container-images/cuda/-/blob/master/dist/11.2.2/ubuntu2004/runtime/Dockerfile

NV_LIBNCCL_PACKAGE_VERSION="2.8.4-1"

# 1792 MB
apt-get install -y --no-install-recommends \
    cuda-libraries-$CUDA_VERSION=$CUDA_LIB_VERSION \
    libnpp-$CUDA_VERSION=11.3.2.152-1 \
    cuda-nvtx-$CUDA_VERSION=$CUDA_PKG_VERSION \
    libcusparse-$CUDA_VERSION=11.4.1.1152-1 \
    libcublas-$CUDA_VERSION=11.4.1.1043-1 \
    libnccl2=$NV_LIBNCCL_PACKAGE_VERSION+cuda11.2

# Keep apt from auto upgrading the cublas and nccl packages. See https://gitlab.com/nvidia/container-images/cuda/-/issues/88
apt-mark hold libcublas-$CUDA_VERSION libnccl2

# 11.2.2-cudnn8-runtime-ubuntu20.04
# see https://gitlab.com/nvidia/container-images/cuda/-/blob/master/dist/11.2.2/ubuntu2004/runtime/cudnn8/Dockerfilele

NV_CUDNN_VERSION="8.1.1.33"

# 1313 MB
apt-get install -y --no-install-recommends \
    libcudnn8=$NV_CUDNN_VERSION-1+cuda11.2 \
    && apt-mark hold libcudnn8
