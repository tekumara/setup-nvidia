#!/bin/bash

# WIP
#
# Script to download CUDA 12.2 components for Linux x86_64
# URLs soured from https://developer.download.nvidia.com/compute/cuda/redist/redistrib_12.2.2.json
# see
# https://docs.nvidia.com/cuda/cuda-installation-guide-linux/#tarball-and-zip-archive-deliverables
# https://github.com/NVIDIA/build-system-archive-import-examples/blob/main/parse_redist.py

BASE_URL="https://developer.download.nvidia.com/compute/cuda/redist/"

set -euo pipefail

# libcublas
echo "Downloading libcublas..."
curl -fsSL -O "$BASE_URL/libcublas/linux-x86_64/libcublas-linux-x86_64-12.2.5.6-archive.tar.xz"

# CUDA CUPTI
echo "Downloading CUDA CUPTI..."
curl -fsSL -O "$BASE_URL/cuda_cupti/linux-x86_64/cuda_cupti-linux-x86_64-12.2.142-archive.tar.xz"

# CUDA NVCC
echo "Downloading CUDA NVCC..."
curl -fsSL -O "$BASE_URL/cuda_nvcc/linux-x86_64/cuda_nvcc-linux-x86_64-12.2.140-archive.tar.xz"

# CUDA NVRTC
echo "Downloading CUDA NVRTC..."
curl -fsSL -O "$BASE_URL/cuda_nvrtc/linux-x86_64/cuda_nvrtc-linux-x86_64-12.2.140-archive.tar.xz"

# CUDA Runtime
echo "Downloading CUDA Runtime (cudart)..."
curl -fsSL -O "$BASE_URL/cuda_cudart/linux-x86_64/cuda_cudart-linux-x86_64-12.2.140-archive.tar.xz"

# libcufft
echo "Downloading libcufft..."
curl -fsSL -O "$BASE_URL/libcufft/linux-x86_64/libcufft-linux-x86_64-11.0.8.103-archive.tar.xz"

# libcurand
echo "Downloading libcurand..."
curl -fsSL -O "$BASE_URL/libcurand/linux-x86_64/libcurand-linux-x86_64-10.3.3.141-archive.tar.xz"

# libcusolver
echo "Downloading libcusolver..."
curl -fsSL -O "$BASE_URL/libcusolver/linux-x86_64/libcusolver-linux-x86_64-11.5.2.141-archive.tar.xz"

# libcusparse
echo "Downloading libcusparse..."
curl -fsSL -O "$BASE_URL/libcusparse/linux-x86_64/libcusparse-linux-x86_64-12.1.2.141-archive.tar.xz"

# NCCL
# echo "Downloading NCCL..."
# requires login
#curl -fsSL -O https://developer.nvidia.com/downloads/compute/machine-learning/nccl/secure/2.26.5/agnostic/x64/nccl_2.26.5-1+cuda12.2_x86_64.txz/

# libnvjitlink
echo "Downloading libnvjitlink..."
curl -fsSL -O "$BASE_URL/libnvjitlink/linux-x86_64/libnvjitlink-linux-x86_64-12.2.140-archive.tar.xz"

# CUDNN
echo "Downloading cuDNN..."
curl -fsSL -O "https://developer.download.nvidia.com/compute/cudnn/redist/cudnn/linux-x86_64/cudnn-linux-x86_64-8.9.6.50_cuda12-archive.tar.xz"

# Optional components - not needed for tensorflow 2.15

# # CUDA NVTX
# echo "Downloading CUDA NVTX..."
# curl -fsSL -O "$BASE_URL/cuda_nvtx/linux-x86_64/cuda_nvtx-linux-x86_64-12.2.140-archive.tar.xz"

# # CUDA OpenCL
# echo "Downloading CUDA OpenCL..."
# curl -fsSL -O "$BASE_URL/cuda_opencl/linux-x86_64/cuda_opencl-linux-x86_64-12.2.140-archive.tar.xz"

# # libcufile
# echo "Downloading libcufile..."
# curl -fsSL -O "$BASE_URL/libcufile/linux-x86_64/libcufile-linux-x86_64-1.7.2.10-archive.tar.xz"

# # libnpp
# echo "Downloading libnpp..."
# curl -fsSL -O "$BASE_URL/libnpp/linux-x86_64/libnpp-linux-x86_64-12.2.1.4-archive.tar.xz"

# # libnvjpeg
# echo "Downloading libnvjpeg..."
# curl -fsSL -O "$BASE_URL/libnvjpeg/linux-x86_64/libnvjpeg-linux-x86_64-12.2.2.4-archive.tar.xz"

echo "Downloads complete."

echo "Extracting tarballs..."
for f in *.tar.xz; do
  tar -xJf "$f"
done
