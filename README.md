# nvidia install scripts for ubuntu 20.04

Includes:

- nvidia kernel drivers
- CUDA 12.2 install scripts adapted from [nvidia/container-images/cuda](https://gitlab.com/nvidia/container-images/cuda)
- [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/overview.html) to allow docker containers to use GPUs.

## But why?

When `sudo apt-get install cuda-toolkit-12-2 libcudnn8` doesn't work.

## Prerequisites

- Ubuntu 22.04
- Install curl: `sudo apt-get install -y curl`

## Usage

Download, extract and run the install scripts:

```
curl -fsSL https://raw.githubusercontent.com/tekumara/setup-nvidia/main/install.sh | bash
```

Download and extract the scripts without running them:

```
curl -fsSL https://raw.githubusercontent.com/tekumara/setup-nvidia/main/install.sh | bash -s -- --skip-install
```

## Test

To test the kernel drivers:

```
nvidia-smi
```

To test the container toolkit:

```
docker run --gpus all --rm nvidia/cuda:11.2.2-cudnn8-runtime-ubuntu20.04 nvidia-smi
```

To diagnose:

```
nvidia-container-cli -k -d /dev/tty info
```

## Docker images

See [images/](images/).

## Development

A Dockerfile is provided to test the scripts. run `make` to see options for building and running the Dockerfile.
