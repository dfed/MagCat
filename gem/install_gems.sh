#!/bin/bash

set -e

# Make sure we're the owner of /Library/Ruby/Gems/
if [ $(stat -f '%Su' /Library/Ruby/Gems/) != "$USER" ]; then
    echo "Setting ownership of /Library/Ruby/Gems/"
    sudo chown -R $USER /Library/Ruby/Gems/
fi

# Install cocoapods if it doesn't exist
if [ -z "$(gem list --no-versions | grep cocoapods)" ]; then
    echo "Installing cocoapods"
    gem install cocoapods
fi

# Install cocoapods if it doesn't exist
if [ -z "$(gem list --no-versions | grep bundler)" ]; then
    echo "Installing bundler"
    gem install bundler
fi
