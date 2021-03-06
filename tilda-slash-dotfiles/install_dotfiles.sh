#!/bin/bash

set -e

DOTFILES_DIR="tilda-slash-dotfiles"

echo "Installing dot files"

for file in $DOTFILES_DIR/* # For each file in $DOTFILES_DIR
do    
    file_name=$(basename "$file")
	if [ "$file_name" == "$(basename $0)" ]; then
		# Skip the current script
		continue
	fi
    
    destination="$PWD/$DOTFILES_DIR/$file_name"
    source="$HOME/.$file_name"
    if [ "$(readlink -- $source)" != $destination ]; then
        echo "- Linking $file_name"
        ln -sF $destination $source
    fi
done

if [ ! -f "$HOME/.custom_bash_profile" ]; then
    echo "- Creating custom_bash_profile"
    touch $HOME/.custom_bash_profile
fi

if [ ! -f "$HOME/.custom_zshrc" ]; then
    echo "- Creating custom_zshrc"
    touch $HOME/.custom_zshrc
fi

if [ ! -z $1 ]; then
    echo "- Writing git_author_email"
    touch $HOME/.git_author_email
    echo "export GIT_AUTHOR_EMAIL=$1; export GIT_COMMITTER_EMAIL=$1; export EMAIL=$1" > $HOME/.git_author_email
else
    echo "- Skipping git_author_email: no email address provided"
fi
