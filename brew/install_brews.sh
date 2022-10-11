#!/bin/bash

set -e

# Install Homebrew if it doesn't exist
if ! which -s brew; then
    echo "Installing brew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Make sure we can continue using brew in this shell before we set up our PATH via dotfiles installation
    eval "$(/opt/homebrew/bin/brew shellenv)"
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
if [ ! -f "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]; then
    echo "Installing bash-completion"
    brew install bash-completion
fi

# Install carthage if it doesn't exist
if ! which -s carthage; then
    echo "Installing carthage"
    brew install carthage
fi

# Install gh if it doesn't exist
if ! which -s gh; then
    echo "Installing gh"
    brew install gh
fi

# Install Xcodes if it doesn't exist
if ! test -d /Applications/Xcodes.app; then
    echo "Installing Xcodes"
    brew install --cask xcodes
fi

# Install DB Browser for SQLite if it doesn't exist
if ! test -d /Applications/DB\ Browser\ for\ SQLite.app; then
    echo "Installing DB Browser for SQLite"
    brew install --cask db-browser-for-sqlite
fi