#!/bin/bash

set -e

./repos/clone.sh $@
./brew/install_brews.sh $@
./gem/install_gems.sh $@
./go/install_go.sh $@
./tilda-slash-preferences/install_preferences.sh $@
./tilda-slash-dotfiles/install_dotfiles.sh $@

echo "Installation complete. Run \`source $HOME/.bash_profile\` to pick up changes."
