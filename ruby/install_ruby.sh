#!/bin/zsh

set -e

echo "Inspecting Ruby…"

echo "hi"
brew info libyaml
brew info readline
brew info openssl@3
brew info gmp
brew info rust

# Install Ruby 3.3.0 if it isn't already installed.
# This version of ruby works well with ARM-based Mac machines.
# 3.3.0 was the latest stable at the time of writing.
# We need Ruby before we install our Gems.
if [[ ! $(rbenv versions --bare) =~ 3.3.0 ]]; then
    echo "Installing ruby 3.3.0"
    rbenv install 3.3.0
    rbenv global 3.3.0
fi
