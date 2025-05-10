#!/usr/bin/env bash

set -euo pipefail

# gnupg2 needed to add third party repos
# curl is used in scripts
# ca-certificates is needed for HTTPS
apt-get update && apt-get install -y --no-install-recommends gnupg2 curl ca-certificates
