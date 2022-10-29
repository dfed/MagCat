#!/bin/zsh

set -e

PREFIX=https://raw.githubusercontent.com/dfed/MagCat/main
if [ "$1" = '--local' ]; then
    echo "Using local clone"
    PREFIX="file://$(git rev-parse --show-toplevel)"
fi

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

# Install Ruby 3.1.2 if it isn't already installed.
# This version of ruby works well with ARM-based Mac machines.
# 3.1.2 was the latest stable at the time of writing.
if [[ ! $(rbenv versions --bare) =~ 3.1.2 ]]; then
    echo "Installing ruby 3.1.2"
    rbenv install 3.1.2
    rbenv global 3.1.2
fi

# Install command line developer tools if they aren't present
if ! which -s make >/dev/null; then
    echo "- Installing command line developer tools"
    xcode-select --install
fi

if [ -z "$(xcodes installed)" ]; then
    echo "- Installing latest Xcode"
    xcodes install --latest
fi

echo
echo "Installation complete. Run the following command to pick up changes:"
echo "source $HOME/.zshrc"
