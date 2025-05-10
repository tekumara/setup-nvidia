#!/usr/bin/env bash

set -uoe pipefail

INSTALL=true
GIT_SHA=main

function die() {
    echo >&2 -e ERROR: "$@"
    exit 1
}

parse_args() {
    while [[ $# -gt 0 ]]; do
        key="$1"

        case $key in
        -s | --skip-install)
            INSTALL=false
            shift # next argument
            ;;
        -g | --git-sha)
            shift
            GIT_SHA="$1"
            shift
            ;;
        *)
            echo "Unrecognized argument $key"
            exit 1
            ;;
        esac
    done
}

parse_args "$@"

tarball_url="https://github.com/tekumara/setup-nvidia/tarball/$GIT_SHA"
echo "Downloading $tarball_url"
if ! curl --progress-bar --fail -L "$tarball_url" -o "/tmp/setup-nvidia.tar.gz"; then
    die "Download failed.  Check that the URL is correct."
fi

dir=/tmp/setup-nvidia
mkdir -p $dir

echo "Extracting install scripts to $dir"
tar -xvf /tmp/setup-nvidia.tar.gz -C $dir --strip-components=1

if [[ "$INSTALL" = false ]]; then
    echo "Skipping install"
else
    set -x

    export DEBIAN_FRONTEND=noninteractive
    sudo $dir/install/system.sh
    sudo $dir/install/nvidia-repo.sh
    sudo $dir/install/nvidia-drivers.sh
    sudo $dir/install/cuda.sh
    sudo $dir/install/nvidia-docker.sh

    echo "Done ✨."
fi
