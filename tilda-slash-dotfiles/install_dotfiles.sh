#!/bin/zsh

set -e

DOTFILES_DIR="tilda-slash-dotfiles"

echo "Inspecting dot files…"

for file in $DOTFILES_DIR/* # For each file in $DOTFILES_DIR
do    
    file_name=$(basename "$file")
	if [[ "$file_name" == "$(basename $0)" ]]; then
		# Skip the current script
		continue
	fi
    
    destination="$PWD/$DOTFILES_DIR/$file_name"
    source="$HOME/.$file_name"
    if [[ "$(readlink -- $source)" != $destination ]]; then
        echo "- Linking $file_name"
        ln -sF $destination $source
    fi
done

if [ -L $HOME/.shared_profile ] && [ ! -e $HOME/.shared_profile ]; then
    echo "- Deleting old .shared_profile link"
    rm $HOME/.shared_profile
fi

if [ -L $HOME/.bash_profile ] && [ ! -e $HOME/.bash_profile ]; then
    echo "- Deleting old .bash_profile link"
    rm $HOME/.bash_profile
fi

if [ -L $HOME/.bashrc ] && [ ! -e $HOME/.bashrc ]; then
    echo "- Deleting old .bashrc link"
    rm $HOME/.bashrc
fi

if [ -f "$HOME/.custom_bash_profile" ]; then
    echo "- Deleting old .custom_bash_profile"
    rm $HOME/.custom_bash_profile
fi

# If our first argument has an '@' symbol in it, it's likely an email address
if [[ $1 == *@* ]]; then
    echo "- Writing git_author_email"
    touch $HOME/.git_author_email
    echo "export GIT_AUTHOR_EMAIL=$1; export GIT_COMMITTER_EMAIL=$1; export EMAIL=$1" > $HOME/.git_author_email
else
    echo "- Skipping git_author_email: no email address provided"
fi
