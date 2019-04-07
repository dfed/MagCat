#!/bin/bash

set -e

function set_plist_key_in_target_to_value {
	TARGET="$HOME/Library/Preferences/$1"
	VALUE="$(git rev-parse --show-toplevel)/tilda-slash-preferences/$2"
	PLIST_KEY="$(basename "$VALUE" | cut -f 1 -d '.')" # Get the name of the plist key from the file name

	/usr/libexec/PlistBuddy -c "Delete :\"$PLIST_KEY\"" $TARGET
	/usr/libexec/PlistBuddy -c "Merge \"$VALUE\"" $TARGET
}

echo "Installing preferences"

for directory in `find . -type d` # For each directory in this directory
do
	if [ "$directory" == "." ]; then
		# Skip the current directory
		continue
	fi
	
	directory_name=$(basename "$directory");
	for file in $directory_name/* # For each file in directory
	do
		file_name=$(basename "$file")
		echo "- Setting preference '$(basename "$file_name" | cut -f 1 -d '.')' in '$directory_name'"
		set_plist_key_in_target_to_value "$directory_name.plist" "$directory_name/$file_name"
	done
done
