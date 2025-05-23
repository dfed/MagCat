#!/bin/zsh

set -e

echo "Inspecting Ruby…"

# Install Ruby if it isn't already installed.
# We need Ruby before we install our Gems.
if [[ ! $(rbenv versions --bare) =~ $1 ]]; then
	echo "Installing ruby $1"
	rbenv install $1 || (brew upgrade ruby-build && rbenv install $1)
	rbenv global $1
fi
