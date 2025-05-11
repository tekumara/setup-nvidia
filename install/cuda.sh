#!/usr/bin/bash

set -euo pipefail

set -x

# Equivalent to the nvidia/cuda:12.2.2-cudnn8-runtime-ubuntu22.04 docker image
# See list of libraries here https://docs.nvidia.com/cuda/eula/index.html#attachment-a

# base
# nvidia/cuda:12.2.2-base-ubuntu22.04
# see https://gitlab.com/nvidia/container-images/cuda/-/blob/5d46571ae3f4b9c6693a57774b4750fd999090ad/dist/12.2.2/ubuntu2204/base/Dockerfile

NV_CUDA_CUDART_VERSION=12.2.140-1
case "$(uname -m)" in
    "aarch64") NV_CUDA_CUDART_VERSION= ;;
    "x86_64")  NV_CUDA_COMPAT_PACKAGE=cuda-compat-12-2 ;;
    *) echo "error: unknown arch $(uname -m)" && exit 42 ;;
esac

#sudo apt-get install -y --no-install-recommends cuda-toolkit-12-2 libcudnn8

apt-get install -y --no-install-recommends \
    cuda-cudart-12-2=${NV_CUDA_CUDART_VERSION} \
    ${NV_CUDA_COMPAT_PACKAGE}

# ln -s cuda-12.2 /usr/local/cuda

# runtime
# nvidia/cuda:12.2.2-runtime-ubuntu22.04
# see https://gitlab.com/nvidia/container-images/cuda/-/blob/5d46571ae3f4b9c6693a57774b4750fd999090ad/dist/12.2.2/ubuntu2204/runtime/Dockerfile

NV_CUDA_LIB_VERSION=12.2.2-1
NV_NVTX_VERSION=12.2.140-1
NV_LIBNPP_VERSION=12.2.1.4-1
NV_LIBNPP_PACKAGE=libnpp-12-2=${NV_LIBNPP_VERSION}
NV_LIBCUSPARSE_VERSION=12.1.2.141-1

NV_LIBCUBLAS_PACKAGE_NAME=libcublas-12-2
NV_LIBCUBLAS_VERSION=12.2.5.6-1
NV_LIBCUBLAS_PACKAGE=${NV_LIBCUBLAS_PACKAGE_NAME}=${NV_LIBCUBLAS_VERSION}

NV_LIBNCCL_PACKAGE_NAME=libnccl2
NV_LIBNCCL_PACKAGE_VERSION=2.19.3-1
NCCL_VERSION=2.19.3-1
NV_LIBNCCL_PACKAGE=${NV_LIBNCCL_PACKAGE_NAME}=${NV_LIBNCCL_PACKAGE_VERSION}+cuda12.2

# XX MB
apt-get install -y --no-install-recommends \
    cuda-libraries-12-2=${NV_CUDA_LIB_VERSION} \
    ${NV_LIBNPP_PACKAGE} \
    cuda-nvtx-12-2=${NV_NVTX_VERSION} \
    libcusparse-12-2=${NV_LIBCUSPARSE_VERSION} \
    ${NV_LIBCUBLAS_PACKAGE} \
    ${NV_LIBNCCL_PACKAGE}

# Keep apt from auto upgrading the cublas and nccl packages. See https://gitlab.com/nvidia/container-images/cuda/-/issues/88
apt-mark hold ${NV_LIBCUBLAS_PACKAGE_NAME} ${NV_LIBNCCL_PACKAGE_NAME}

# cudnn8
# nvidia/cuda:12.2.2-cudnn8-runtime-ubuntu22.04
# see https://gitlab.com/nvidia/container-images/cuda/-/blob/5d46571ae3f4b9c6693a57774b4750fd999090ad/dist/12.2.2/ubuntu2204/runtime/cudnn8/Dockerfile

NV_CUDNN_VERSION=8.9.6.50
NV_CUDNN_PACKAGE_NAME="libcudnn8"
NV_CUDNN_PACKAGE="libcudnn8=$NV_CUDNN_VERSION-1+cuda12.2"

# XX MB
apt-get install -y --no-install-recommends \
    ${NV_CUDNN_PACKAGE} \
    && apt-mark hold ${NV_CUDNN_PACKAGE_NAME}

rm -rf /var/lib/apt/lists/*
