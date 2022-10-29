#!/bin/zsh

set -e

echo "Installing brew + formulae…"

# Install Homebrew if it doesn't exist
if ! which -s brew >/dev/null; then
    echo "- Installing brew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Make sure we can continue using brew in this shell before we set up our PATH via dotfiles installation
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Install terminal-notifier if it doesn't exist
if ! which -s terminal-notifier >/dev/null; then
    echo "- Installing terminal-notifier"
    brew install terminal-notifier
fi

# Install git if it hasn't been installed by brew.
# We want at least version 2.38, which at the time of writing was current stable release.
# We install with brew because its stable version is ahead of Xcode's.
if [ -z "$(brew list --versions git)" ]; then
    echo "- Installing git"
    brew install git
fi

# Install bash-completion if it doesn't exist
if [ ! -f "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]; then
    echo "- Installing bash-completion"
    brew install bash-completion
fi

# Install carthage if it doesn't exist
if ! which -s carthage >/dev/null; then
    echo "- Installing carthage"
    brew install carthage
fi

# Install gh if it doesn't exist
if ! which -s gh >/dev/null; then
    echo "- Installing gh"
    brew install gh
fi

# Install Xcodes if it doesn't exist
if ! test -d /Applications/Xcodes.app; then
    echo "- Installing Xcodes"
    brew install --cask xcodes
fi

# Install DB Browser for SQLite if it doesn't exist
if ! test -d /Applications/DB\ Browser\ for\ SQLite.app; then
    echo "- Installing DB Browser for SQLite"
    brew install --cask db-browser-for-sqlite
fi