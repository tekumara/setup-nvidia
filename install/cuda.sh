#!/usr/bin/env bash

set -euo pipefail

set -x

# Equivalent to the nvidia/cuda:11.2.2-cudnn8-runtime-ubuntu20.04 docker image
# See list of libraries here https://docs.nvidia.com/cuda/eula/index.html#attachment-a

# 11.2.2-base-ubuntu20.04
# see https://gitlab.com/nvidia/container-images/cuda/-/blob/f697642af388d3de88f4b8ccea3271cd3b5be03e/dist/11.2.2/ubuntu2004/base/Dockerfile

NV_CUDA_CUDART_VERSION=11.2.152-1
NV_CUDA_COMPAT_PACKAGE=cuda-compat-11-2

# 30 MB
apt-get install -y --no-install-recommends \
    cuda-cudart-11-2=${NV_CUDA_CUDART_VERSION} \
    ${NV_CUDA_COMPAT_PACKAGE} \
    && ln -s cuda-11.2 /usr/local/cuda

# 11.2.2-runtime-ubuntu20.04
# see https://gitlab.com/nvidia/container-images/cuda/-/blob/3918843140ee1ac08c8a100a5f219982a6ae1867/dist/11.2.2/ubuntu2004/runtime/Dockerfile

NV_CUDA_LIB_VERSION=11.2.2-1
NV_NVTX_VERSION=11.2.152-1
NV_LIBNPP_VERSION=11.3.2.152-1
NV_LIBNPP_PACKAGE=libnpp-11-2=${NV_LIBNPP_VERSION}
NV_LIBCUSPARSE_VERSION=11.4.1.1152-1

NV_LIBCUBLAS_PACKAGE_NAME=libcublas-11-2
NV_LIBCUBLAS_VERSION=11.4.1.1043-1
NV_LIBCUBLAS_PACKAGE=${NV_LIBCUBLAS_PACKAGE_NAME}=${NV_LIBCUBLAS_VERSION}

NV_LIBNCCL_PACKAGE_NAME=libnccl2
NV_LIBNCCL_PACKAGE_VERSION=2.8.4-1
NV_LIBNCCL_PACKAGE=${NV_LIBNCCL_PACKAGE_NAME}=${NV_LIBNCCL_PACKAGE_VERSION}+cuda11.2

# 1792 MB
apt-get install -y --no-install-recommends \
    cuda-libraries-11-2=${NV_CUDA_LIB_VERSION} \
    ${NV_LIBNPP_PACKAGE} \
    cuda-nvtx-11-2=${NV_NVTX_VERSION} \
    libcusparse-11-2=${NV_LIBCUSPARSE_VERSION} \
    ${NV_LIBCUBLAS_PACKAGE} \
    ${NV_LIBNCCL_PACKAGE}

# Keep apt from auto upgrading the cublas and nccl packages. See https://gitlab.com/nvidia/container-images/cuda/-/issues/88
apt-mark hold ${NV_LIBCUBLAS_PACKAGE_NAME} ${NV_LIBNCCL_PACKAGE_NAME}

# 11.2.2-cudnn8-runtime-ubuntu20.04
# see https://gitlab.com/nvidia/container-images/cuda/-/blob/4a254e3ee92a110db2d225f09c3028022d34a463/dist/11.2.2/ubuntu2004/runtime/cudnn8/Dockerfile

NV_CUDNN_VERSION=8.1.1.33
NV_CUDNN_PACKAGE_NAME="libcudnn8"
NV_CUDNN_PACKAGE="libcudnn8=$NV_CUDNN_VERSION-1+cuda11.2"

# 1313 MB
apt-get install -y --no-install-recommends \
    ${NV_CUDNN_PACKAGE} \
    && apt-mark hold ${NV_CUDNN_PACKAGE_NAME}

rm -rf /var/lib/apt/lists/*
