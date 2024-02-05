#!/bin/zsh

set -e

echo "Inspecting Ruby…"

# Install Ruby 3.2.3 if it isn't already installed.
# This version of ruby works well with ARM-based Mac machines.
# 3.2.3 was the latest stable at the time of writing.
# We need Ruby before we install our Gems.
if [[ ! $(rbenv versions --bare) =~ 3.2.3 ]]; then
    echo "Installing ruby 3.2.3"
    rbenv install 3.2.3
    rbenv global 3.2.3
fi
