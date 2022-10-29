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

./tilda-slash-preferences/install_preferences.sh $@
./tilda-slash-dotfiles/install_dotfiles.sh $@

echo
echo "Installation complete. Run the following command to pick up changes:"
echo "source $HOME/.zshrc"
