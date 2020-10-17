#!/usr/bin/env bash

user_dirs=(
    bin
    emacs
    fish
    git
    karabiner
    ruby
    tmux
    vim
)

stowit() {
    usr=$1
    app=$2

    stow -v -R -t ${usr} ${app}
}

echo ""
echo "Stowing apps for user: ${whoami}"

for app in ${user_dirs[@]}; do
    stowit "${HOME}" $app
done

echo ""
echo "Done"
