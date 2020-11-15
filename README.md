# nvidia install scripts for ubuntu 18.04

Includes:

- nvidia kernel drivers
- CUDA 10.1 install scripts adapted from [nvidia/container-images/cuda](https://gitlab.com/nvidia/container-images/cuda/-/tree/master/dist/10.1/ubuntu18.04-x86_64)
- [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/overview.html) to allow docker containers to use GPUs.

## Prequisities

- Ubuntu 18.04
- Install curl & sudo: `sudo apt-get update && sudo apt-get install -y curl sudo`

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
docker run --gpus all --rm nvidia/cuda:10.1-cudnn7-runtime-ubuntu18.04 nvidia-smi
```

To diagnose:

```
nvidia-container-cli -k -d /dev/tty info
```

## Development

A Dockerfile is provided to test the scripts. run `make` to see options for building and running the Dockerfile.
