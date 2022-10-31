#!/bin/zsh

set -e

PREFIX=https://raw.githubusercontent.com/dfed/MagCat/main
if [ "$1" = '--local' ]; then
    echo "Using local clone"
    PREFIX="file://$(git rev-parse --show-toplevel)"
fi

# Ensure our PATH is set up
source <(curl -Ls $PREFIX/path_setup)

# Install our common tools, including git
zsh <(curl -Ls $PREFIX/brew/install_brews.sh) $@
zsh <(curl -Ls $PREFIX/gem/install_gems.sh) $@

# Now that we have git, we can clone our repos
zsh <(curl -Ls $PREFIX/repos/clone.sh) $@
# Now that we have our repo, we can cd into it.
cd $HOME/source/MagCat
# Make sure we're on the latest version.
git fetch --quiet
CURRENT_SHA=$(git rev-list HEAD | head -1)
REMOTE_SHA=$(git rev-list origin/main | head -1)
if [ $CURRENT_SHA != $REMOTE_SHA ]; then
    >&2 echo '- Stopping install: current HEAD not the same as origin/main.'
    exit 1
fi

./tilda-slash-preferences/install_preferences.sh $@
./tilda-slash-dotfiles/install_dotfiles.sh $@

# Skip Xcode installs in CI.
if [ "$1" != '--ci' ]; then
    # Install command line developer tools if they aren't present
    if ! which -s make >/dev/null; then
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
