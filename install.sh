#!/bin/bash

set -e

./repos/clone.sh $@
./brew/install_brews.sh $@
./gem/install_gems.sh $@
./go/install_go.sh $@
./tilda-slash-preferences/install_preferences.sh $@
./tilda-slash-dotfiles/install_dotfiles.sh $@

echo "Installation complete. Run the following command to pick up changes:"
echo "source $HOME/.zshrc"
