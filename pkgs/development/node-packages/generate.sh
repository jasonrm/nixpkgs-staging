#!/usr/bin/env bash

set -eu -o pipefail

cd "$( dirname "${BASH_SOURCE[0]}" )"

rm -f ./node-env.nix

# Track the latest active nodejs LTS here: https://nodejs.org/en/about/releases/
node2nix \
    -i node-packages.json \
    -o node-packages.nix \
    -c composition.nix \
    --pkg-name nodejs-18_x
