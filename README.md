# dotfiles
My collection of dotfiles

## Setup
```sh
$ brew install stow
$ git clone git@github.com:yujinyuz/dotfiles.git
$ ./syncdots
```

## Update Brewfile
```
$ brew bundle dump --file=macos/Brewfile --force
```

## Install FZF Completions
```
/usr/local/opt/fzf/install --no-bash --no-zsh --no-update-rc --key-bindings --completion
```

## Install asdf completions

```
cp -iv ~/.asdf/completions/asdf.fish ~/.config/fish/completions/
```


## Remove Desktop Icons

Useful when you just dump stuffs to your desktop but don't want to see it

```console
defaults write com.apple.finder CreateDesktop false
killall Finder
```
