#!/bin/bash

set -e

function clone_repo_into_destination {
    REPO=$1
    DESTINATION=$2

    if [ ! -d "$DESTINATION" ]; then
        echo "Cloning $REPO"
        gh repo clone $REPO $DESTINATION
    fi
}

if ! gh auth status -h github.com >/dev/null 2>&1; then
    echo "You must create a github auth session before cloning"
    gh auth login
fi

clone_repo_into_destination dfed/CacheAdvance $HOME/source/CacheAdvance
clone_repo_into_destination dfed/FancyPantsPS1 $HOME/source/FancyPantsPS1
clone_repo_into_destination dfed/Relativity $HOME/source/Relativity
clone_repo_into_destination dfed/XCTest-watchOS $HOME/source/XCTest-watchOS
clone_repo_into_destination square/Aardvark $HOME/source/Aardvark
clone_repo_into_destination square/Valet $HOME/source/Valet
