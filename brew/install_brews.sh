#!/bin/zsh

set -e

echo "Inspecting brew + formulae…"

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

# Install git-lfs if it hasn't been installed via brew.
# This is a useful tool, and since we're installing `git` manually we should also intall git-lfs manually.
if [ -z "$(brew list --versions git-lfs)" ]; then
    echo "- Installing git-lfs"
    brew install git-lfs
fi

# Install gpg if it doesn't exist
if ! which -s gpg >/dev/null; then
    echo "- Installing gpg"
    brew install gpg-suite-no-mail
fi

# Install rbenv if it doesn't exist
if ! which -s rbenv >/dev/null; then
    echo "- Installing rbenv"
    brew install rbenv

    # Install ruby-build if it doesn't exist.
    if ! which -s ruby-build >/dev/null; then
        echo "- Installing ruby-build"
        brew install ruby-build
    fi

    # Now that we have rbenv, initialize it so we can find it later.
    eval "$(rbenv init - zsh)"
fi

# Install carthage if it doesn't exist
if ! which -s carthage >/dev/null; then
    echo "- Installing carthage"
    brew install carthage
fi

# Install aria2 if it doesn't exist
if ! brew list --quiet aria2 >/dev/null; then
    echo " - Installing aria2"
    brew install aria2
fi

# Install gh if it doesn't exist
if ! which -s gh >/dev/null; then
    echo "- Installing gh"
    brew install gh
fi

# Install XcodesApp if it doesn't exist
if ! test -d /Applications/Xcodes.app; then
    echo "- Installing XcodesApp"
    brew install --cask xcodes
fi

# Install Xcodes if it doesn't exist
if ! which -s xcodes >/dev/null; then
    echo "- Installing xcodes"
    brew install robotsandpencils/made/xcodes
    # Explicitly link since installing XcodesApp first can cause that step to be skipped.
    brew link xcodes
fi

# Install macdown if it doesn't exist
if ! brew list --quiet macdown >/dev/null; then
    echo " - Installing macdown"
    brew install --cask macdown
fi

# Install DB Browser for SQLite if it doesn't exist
if ! test -d /Applications/DB\ Browser\ for\ SQLite.app; then
    echo "- Installing DB Browser for SQLite"
    brew install --cask db-browser-for-sqlite
fi

echo "- Upgrading brews"
brew upgrade
