#!/bin/zsh

set -e

pushd "$(git rev-parse --show-toplevel)"

if [[ -z $(git status --porcelain) ]]; then
	git ls-files -z '*.sh' | xargs -0 shfmt -w
else
	git status --porcelain
	echo "Exiting - repo not clean"
	exit 1
fi

popd
