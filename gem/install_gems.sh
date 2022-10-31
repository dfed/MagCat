#!/bin/zsh

set -e

echo "Inspecting gems…"

# Install Ruby 3.1.2 if it isn't already installed.
# This version of ruby works well with ARM-based Mac machines.
# 3.1.2 was the latest stable at the time of writing.
# We need Ruby before we install our Gems.
if [[ ! $(rbenv versions --bare) =~ 3.1.2 ]]; then
    echo "Installing ruby 3.1.2"
    rbenv install 3.1.2
    rbenv global 3.1.2
fi

# Install bundler if it doesn't exist
if [ -z "$(gem list --no-versions | grep bundler)" ]; then
    echo "- Installing bundler"
    gem install --user-install bundler
fi
