#!/bin/zsh

set -e

echo "Inspecting Ruby…"

# Install Ruby 3.4.4 if it isn't already installed.
# This version of ruby works well with ARM-based Mac machines.
# 3.4.4 was the latest stable at the time of writing.
# We need Ruby before we install our Gems.
if [[ ! $(rbenv versions --bare) =~ 3.4.4 ]]; then
	echo "Installing ruby 3.4.4"
	rbenv install 3.4.4
	rbenv global 3.4.4
fi
