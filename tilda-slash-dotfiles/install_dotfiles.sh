#!/bin/bash

set -e

echo "Installing dot files"

for file in tilda-slash-dotfiles/* # For each file in tilda-slash-dotfiles
do    
    file_name=$(basename "$file")
	if [ "$file_name" == "$(basename $0)" ]; then
		# Skip the current script
		continue
	fi    
    
    echo "- Linking $file_name"
    ln -sF $PWD/$file_name "$HOME/.$file_name"
done

if [ ! -f "$HOME/.custom_bash_profile" ]; then
    echo "- Creating custom_bash_profile"
    touch $HOME/.custom_bash_profile
fi

if [ ! -z $1 ]; then
    echo "- Writing git_author_email"
    touch $HOME/.git_author_email
    echo "export GIT_AUTHOR_EMAIL=$1; export GIT_COMMITTER_EMAIL=$1; export EMAIL=$1" > $HOME/.git_author_email
else
    echo "- Skipping git_author_email: no email address provided"
fi
