#!/usr/bin/env bash

set -uoe pipefail

INSTALL=true

parse_args() {
    while [[ $# -gt 0 ]]; do
        key="$1"

        case $key in
        -s | --skip-install)
            INSTALL=false
            shift # past argument
            ;;
        *)
            echo "Unrecognized argument $key"
            exit 1
            ;;
        esac
    done
}

parse_args "$@"

TARBALL_URL=$(curl -s https://api.github.com/repos/tekumara/setup-nvidia/releases/latest | grep tarball | cut -d '"' -f 4)

if ! curl --progress-bar --fail -L "$TARBALL_URL" -o "/tmp/setup-nvidia.tar.gz"; then
    echo "Download failed.  Check that the release/filename are correct."
    exit 1
fi

echo "Extracting install scripts to /tmp/"
tar -xvf /tmp/setup-nvidia.tar.gz -C /tmp --strip-components=1

if [[ "$INSTALL" = false ]]; then
    echo "Skipping install"
else
    set -x

    export DEBIAN_FRONTEND=noninteractive
    sudo /tmp/install/system.sh
    sudo /tmp/install/nvidia-drivers.sh
    sudo /tmp/install/cuda.sh
    sudo /tmp/install/nvidia-docker.sh
fi
