#!/bin/zsh

set -e

PREFERENCES_DIR="tilda-slash-preferences"

function set_plist_key_in_target_to_value {
	TARGET="$HOME/Library/Preferences/$1"
	VALUE="$(git rev-parse --show-toplevel)/$PREFERENCES_DIR/$2"
	PLIST_KEY="$(basename "$VALUE" | cut -f 1 -d '.')" # Get the name of the plist key from the file name

	if [ ! -f "$TARGET" ]; then
		/usr/libexec/PlistBuddy -c "Save" "$TARGET"
	fi

	/usr/libexec/PlistBuddy -c "Delete :\"$PLIST_KEY\"" $TARGET
	/usr/libexec/PlistBuddy -c "Merge \"$VALUE\"" $TARGET
}

echo "Installing preferences…"

for directory in `find $(git rev-parse --show-toplevel)/$PREFERENCES_DIR/ -type d` # For each directory in this directory
do
    directory_name=$(basename "$directory");
	if [[ "$directory_name" == "$PREFERENCES_DIR" ]]; then
		# Skip the current directory
		continue
	fi
	
	for file in $PREFERENCES_DIR/$directory_name/* # For each file in directory
	do
		file_name=$(basename "$file")
        echo "- Setting preference '$(basename "$file_name" | cut -f 1 -d '.')' in '$directory_name'"
        set_plist_key_in_target_to_value "$directory_name.plist" "$directory_name/$file_name"
	done
done
