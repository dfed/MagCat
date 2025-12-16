#!/bin/zsh

set -e

echo "Inspecting brew + formulae…"

# Install Homebrew if it doesn't exist
if ! command -v brew >/dev/null; then
	echo "- Installing brew"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	# Make sure we can continue using brew in this shell before we set up our PATH via dotfiles installation
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Determine the Brewfile location
# When run locally from the repo, use the local Brewfile
# When run remotely via curl, download the Brewfile to a temp location
if [ "$1" = '--local' ]; then
	BREWFILE="$(git rev-parse --show-toplevel)/Brewfile"
else
	PREFIX="https://raw.githubusercontent.com/dfed/MagCat/${GITHUB_SHA:-main}"
	BREWFILE="$(mktemp)"
	curl -Ls "$PREFIX/Brewfile" -o "$BREWFILE"
	trap "rm -f $BREWFILE" EXIT
fi

# Install/upgrade dependencies from Brewfile
# brew bundle auto-updates Homebrew, installs missing packages, and upgrades outdated ones
echo "Installing dependencies from Brewfile…"
brew bundle --file="$BREWFILE" --upgrade || echo "Warning: brew bundle failed. One or more Brewfile dependencies failed to install."

# Explicitly link xcodes since installing XcodesApp first can cause that step to be skipped
if ! command -v xcodes >/dev/null; then
	echo "- Linking xcodes"
	brew link xcodesorg/made/xcodes
fi

# Initialize rbenv for use in subsequent scripts
if command -v rbenv >/dev/null; then
	eval "$(rbenv init - zsh)"
fi
