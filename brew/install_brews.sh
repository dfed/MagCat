#!/bin/bash

set -e

# Install Homebrew if it doesn't exist
if ! which -s brew; then
    echo "Installing brew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install terminal-notifier if it doesn't exist
if ! which -s terminal-notifier; then
    echo "Installing terminal-notifier"
    brew install terminal-notifier
fi

# Install carthage if it doesn't exist
if ! which -s carthage; then
    echo "Installing carthage"
    brew install carthage
fi

# Install go if it doesn't exist
if ! which -s go; then
    echo "Installing go"
    brew install go
fi
