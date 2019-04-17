#!/bin/bash

set -e

# Install cocoapods if it doesn't exist
if [ -z "$(gem list --no-versions | grep cocoapods)" ]; then
    echo "Installing cocoapods"
    gem install --user-install cocoapods
fi

# Install bundler if it doesn't exist
if [ -z "$(gem list --no-versions | grep bundler)" ]; then
    echo "Installing bundler"
    gem install --user-install bundler
fi
