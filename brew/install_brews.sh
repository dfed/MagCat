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

# Install git if it doesn't exist
if ! which -s git; then
    echo "Installing git"
    brew install git
fi

# Install bash-completion if it doesn't exist
if [ ! -f /opt/homebrew/etc/profile.d/bash_completion.sh ]; then
    echo "Installing bash-completion"
    brew install bash-completion
fi

# Install carthage if it doesn't exist
if ! which -s carthage; then
    echo "Installing carthage"
    brew install carthage
fi
