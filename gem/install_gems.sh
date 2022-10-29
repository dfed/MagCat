#!/bin/zsh

set -e

echo "Inspecting gems…"

# Install bundler if it doesn't exist
if [ -z "$(gem list --no-versions | grep bundler)" ]; then
    echo "- Installing bundler"
    gem install --user-install bundler
fi
