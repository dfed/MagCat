#!/bin/bash

set -e

# Install bundler if it doesn't exist
if [ -z "$(gem list --no-versions | grep bundler)" ]; then
    echo "Installing bundler"
    gem install --user-install bundler
fi
