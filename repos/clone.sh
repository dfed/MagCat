#!/bin/bash

set -e

function clone_repo_into_destination {
    REPO=$1
    DESTINATION=$2

    if [ ! -d "$DESTINATION" ]; then
        echo "Cloning $REPO"
        git clone $REPO $DESTINATION
    fi
}

clone_repo_into_destination git@github.com:airbnb/BuckSample.git $HOME/Documents/source/BuckSample
clone_repo_into_destination git@github.com:dfed/CacheAdvance.git $HOME/Documents/source/CacheAdvance
clone_repo_into_destination git@github.com:dfed/FancyPantsPS1.git $HOME/Documents/source/FancyPantsPS1
clone_repo_into_destination git@github.com:dfed/grb.git $HOME/Documents/source/grb
clone_repo_into_destination git@github.com:dfed/Relativity.git $HOME/Documents/source/Relativity
clone_repo_into_destination git@github.com:dfed/XCTest-watchOS.git $HOME/Documents/source/XCTest-watchOS
clone_repo_into_destination git@github.com:square/Aardvark.git $HOME/Documents/source/Aardvark
clone_repo_into_destination git@github.com:square/Valet.git $HOME/Documents/source/Valet
