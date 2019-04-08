#!/bin/bash

set -e

function clone_repo_into_destination {
    REPO=$1
    DESTINATION=$2

    if [ ! -d "$DESTINATION" ]; then
        git clone $REPO $DESTINATION
    else
        echo "Skipping $REPO -- $DESTINATION already exists"
    fi
}

pushd $HOME/Documents > /dev/null 2>&1
echo "Cloning repositories"
clone_repo_into_destination git@github.com:dfed/FancyPantsPS1.git $HOME/Documents/source/FancyPantsPS1
popd > /dev/null 2>&1

# Make sure we're the owner of /Library/Ruby/Gems/
if [ $(stat -f '%Su' /Library/Ruby/Gems/) != "$USER" ]; then
    echo "Setting ownership of /Library/Ruby/Gems/"
    sudo chown -R $USER /Library/Ruby/Gems/
fi

# Install Homebrew if it doesn't exist
if ! which -s brew; then
    echo "Installing Homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install go if it doesn't exist
if ! which -s go; then
    echo "Installing go"
    brew install go
fi

# Install grb if it doesn't exist
if ! which -s grb; then
    echo "Installing grb"
    go get -u github.com/dfed/grb && go build github.com/dfed/grb && mv -f grb /usr/local/bin/
fi

# Install terminal-notifier if it doesn't exist
if ! which -s terminal-notifier; then
    echo "Installing terminal-notifier"
    brew install terminal-notifier
fi

# Install carthage if it doesn't exist
if ! which -s carthage; then
    echo "Installing carthage"
    brew install carthage
fi

# Install cocoapods if it doesn't exist
if [ -z "$(gem list --no-versions | grep cocoapods)" ]; then
    echo "Installing cocoapods"
    gem install cocoapods
fi

# Install cocoapods if it doesn't exist
if [ -z "$(gem list --no-versions | grep bundler)" ]; then
    echo "Installing bundler"
    gem install bundler
fi

pushd tilda-slash-preferences > /dev/null 2>&1
./install_preferences.sh
popd > /dev/null 2>&1

echo "Installing dot files"

echo "- Creating custom_bash_profile"
touch $HOME/.custom_bash_profile

if [ ! -z $1 ]; then
    echo "- Writing git_author_email"
    touch $HOME/.git_author_email
    echo "export GIT_AUTHOR_EMAIL=$1; export GIT_COMMITTER_EMAIL=$1; export EMAIL=$1" > $HOME/.git_author_email
else
    echo "- Skipping git_author_email: no email address provided"
fi

pushd tilda-slash-dotfiles > /dev/null 2>&1
for file in * # For each file in tilda-slash-dotfiles
do
    file_name=$(basename "$file")
    echo "- Linking $file_name"
    ln -sF $PWD/$file_name "$HOME/.$file_name"
done
popd > /dev/null 2>&1

echo "Installation complete. Run \`source $HOME/.bash_profile\` to pick up changes."
