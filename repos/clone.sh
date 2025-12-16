#!/bin/zsh

set -e

echo "Inspecting repos…"

function clone_repo_into_destination {
	REPO="$1"
	DESTINATION="$HOME/source/$(basename "$REPO")"

	if [ ! -d "$DESTINATION" ]; then
		echo "- Cloning $REPO"
		gh repo clone "$REPO" "$DESTINATION"
	fi
}

# Skip github authentication and cloning if there's no UI allowed.
if [ "$1" != '--no-ui' ]; then
	if ! gh auth status -h github.com >/dev/null 2>&1; then
		echo "You must create a github auth session before cloning"
		gh auth login
	fi

	clone_repo_into_destination dfed/MagCat
	clone_repo_into_destination dfed/SafeDI
	clone_repo_into_destination dfed/swift-async-queue
	clone_repo_into_destination dfed/swift-testing-expectation
	clone_repo_into_destination dfed/CacheAdvance
	clone_repo_into_destination dfed/FancyPantsPS1
	clone_repo_into_destination square/Valet
fi
