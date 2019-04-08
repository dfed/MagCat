#!/bin/bash

set -e

function clone_repo_into_destination {
    REPO=$1
    DESTINATION=$2

    if [ ! -d "$DESTINATION" ]; then
        git clone $REPO $DESTINATION
    fi
}

echo "Cloning repositories"

clone_repo_into_destination git@github.com:dfed/FancyPantsPS1.git $HOME/Documents/source/FancyPantsPS1
clone_repo_into_destination git@github.com:dfed/grb.git $HOME/Documents/source/grb
clone_repo_into_destination git@github.com:dfed/Relativity.git $HOME/Documents/source/Relativity
clone_repo_into_destination git@github.com:dfed/XCTest-watchOS.git $HOME/Documents/source/XCTest-watchOS
clone_repo_into_destination git@github.com:Square/Aardvark.git $HOME/Documents/source/Aardvark
clone_repo_into_destination git@github.com:Square/Valet.git $HOME/Documents/source/Valet
clone_repo_into_destination git@github.com:Airbnb/BuckSample.git $HOME/Documents/source/BuckSample
