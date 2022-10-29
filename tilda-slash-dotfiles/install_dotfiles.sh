#!/bin/bash

set -e

DOTFILES_DIR="tilda-slash-dotfiles"

echo "Installing dot files…"

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

if [ ! -f "$HOME/.bashrc" ]; then
    echo "- Creating .bashrc"
    # Make non-login shell use setup from `.bash_profile`
    ln -sF $HOME/.bash_profile $HOME/.bashrc
fi

if [ ! -f "$HOME/.custom_bash_profile" ]; then
    echo "- Creating custom_bash_profile"
    touch $HOME/.custom_bash_profile
fi

if [ ! -f "$HOME/.custom_zshrc" ]; then
    echo "- Creating custom_zshrc"
    touch $HOME/.custom_zshrc
fi

# If our first argument has an '@' symbol in it, it's likely an email address
if [[ $1 == *@* ]]; then
    echo "- Writing git_author_email"
    touch $HOME/.git_author_email
    echo "export GIT_AUTHOR_EMAIL=$1; export GIT_COMMITTER_EMAIL=$1; export EMAIL=$1" > $HOME/.git_author_email
else
    echo "- Skipping git_author_email: no email address provided"
fi

if [[ ! $(rbenv versions --bare) =~ 3.1.2 ]]; then
    echo "- Installing ruby 3.1.2"
    rbenv install 3.1.2
    rbenv global 3.1.2
fi
