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

clone_repo_into_destination git@github.com:airbnb/BuckSample.git $HOME/source/BuckSample
clone_repo_into_destination git@github.com:dfed/CacheAdvance.git $HOME/source/CacheAdvance
clone_repo_into_destination git@github.com:dfed/FancyPantsPS1.git $HOME/source/FancyPantsPS1
clone_repo_into_destination git@github.com:dfed/grb.git $HOME/source/grb
clone_repo_into_destination git@github.com:dfed/Relativity.git $HOME/source/Relativity
clone_repo_into_destination git@github.com:dfed/XCTest-watchOS.git $HOME/source/XCTest-watchOS
clone_repo_into_destination git@github.com:square/Aardvark.git $HOME/source/Aardvark
clone_repo_into_destination git@github.com:square/Valet.git $HOME/source/Valet
