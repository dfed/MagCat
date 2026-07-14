#!/bin/zsh

set -e

PREFIX="https://raw.githubusercontent.com/dfed/MagCat/${GITHUB_SHA:-main}"
if [ "$1" = '--local' ]; then
	echo "Using local clone"
	PREFIX="file://$(git rev-parse --show-toplevel)"
fi

# Ensure our PATH is set up
source <(curl -Ls $PREFIX/path_setup)

# Install our common tools, including git
zsh <(curl -Ls $PREFIX/brew/install_brews.sh) $@
zsh <(curl -Ls $PREFIX/ruby/install_ruby.sh) $(curl $PREFIX/tilda-slash-dotfiles/ruby-version)

# Now that we have git, we can clone our repos
zsh <(curl -Ls $PREFIX/repos/clone.sh) $@
# Now that we have our repo, we can cd into it.
cd $HOME/source/MagCat

./tilda-slash-preferences/install_preferences.sh $@
./tilda-slash-dotfiles/install_dotfiles.sh $@

# Point gpg-agent at pinentry-mac so GPG commit signing reads the passphrase from
# the macOS login Keychain. Without this, gpg falls back to a terminal pinentry
# (pinentry-curses) that can't prompt in a headless/background session (e.g. an
# agent-driven worktree), so signing times out once the passphrase cache lapses.
# Idempotent: only appends the line if it isn't already there.
mkdir -p "$HOME/.gnupg"
chmod 700 "$HOME/.gnupg"
if ! grep -q '^pinentry-program' "$HOME/.gnupg/gpg-agent.conf" 2>/dev/null; then
	echo "- Configuring gpg-agent to use pinentry-mac"
	echo "pinentry-program $(command -v pinentry-mac || echo /opt/homebrew/bin/pinentry-mac)" >>"$HOME/.gnupg/gpg-agent.conf"
	gpgconf --kill gpg-agent 2>/dev/null || true
fi

mkdir -p $HOME/Library/Developer/Xcode/UserData/KeyBindings/
ln -sF $HOME/source/MagCat/xcode/Default.idekeybindings $HOME/Library/Developer/Xcode/UserData/KeyBindings/Default.idekeybindings

# Initialize git-lfs if not already configured
if ! git lfs env >/dev/null 2>&1 || ! git config --get-regex 'filter\.lfs' >/dev/null 2>&1; then
	echo "- Initializing git-lfs"
	git lfs install
fi

# Skip Xcode installs if there's no UI allowed.
if [ "$1" != '--no-ui' ]; then
	# Install command line developer tools if they aren't present
	if ! command -v make >/dev/null; then
		echo "- Installing command line developer tools"
		xcode-select --install
	fi

	if [ -z "$(xcodes installed)" ]; then
		echo "- Installing latest Xcode"
		xcodes install --latest
	fi
fi

echo
echo "Installation complete. Run the following command to pick up changes:"
echo "source $HOME/.zshrc"
