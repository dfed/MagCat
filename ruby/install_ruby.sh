#!/bin/zsh

set -e

echo "Inspecting Ruby…"

# Install Ruby 3.4.4 if it isn't already installed.
# This version of ruby works well with ARM-based Mac machines.
# 3.4.4 was the latest stable at the time of writing.
# We need Ruby before we install our Gems.
if [[ ! $(rbenv versions --bare) =~ $1 ]]; then
	echo "Installing ruby $1"
	rbenv install $1
	rbenv global $1
fi
