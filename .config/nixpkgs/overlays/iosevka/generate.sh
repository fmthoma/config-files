#!/usr/bin/env nix-shell
#!nix-shell -p nodePackages.node2nix -i bash

if [ ! -e package.json ]; then
    echo "./package.json not found"
    echo "Place this script in the iosevka directory and re-run"
    echo "Then copy node-env.nix and node-packages.nix into this directory"
    exit 1
fi

node2nix -c /dev/null -d -l package-lock.json
