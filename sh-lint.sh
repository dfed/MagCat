#!/bin/zsh

set -e

pushd "$(git rev-parse --show-toplevel)"

if [[ -z $(git status --porcelain) ]]; then
	shfmt -w $(git ls-files '*.sh')
else
	git status --porcelain
	echo "Exiting - repo not clean"
	exit 1
fi

popd
