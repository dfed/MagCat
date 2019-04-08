#!/bin/bash

set -e

# Install grb if it doesn't exist
if ! which -s grb; then
    echo "Installing grb"
    go get -u github.com/dfed/grb && go build github.com/dfed/grb && mv -f grb /usr/local/bin/
fi
