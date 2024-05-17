#!/bin/zsh

set -e

echo "Inspecting Ruby…"

# Install Ruby 3.3.1 if it isn't already installed.
# This version of ruby works well with ARM-based Mac machines.
# 3.3.1 was the latest stable at the time of writing.
# We need Ruby before we install our Gems.
if [[ ! $(rbenv versions --bare) =~ 3.3.1 ]]; then
    echo "Installing ruby 3.3.1"
    rbenv install 3.3.1
    rbenv global 3.3.1
fi
