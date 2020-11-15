#!/usr/bin/env bash

set -euo pipefail

set -x

apt-get update

# gnupg2 needed to add third party repos
apt-get install -y --no-install-recommends gnupg2
