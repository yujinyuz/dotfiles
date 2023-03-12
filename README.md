# dotfiles
My collection of dotfiles

## Setup
```sh
$ brew install stow
$ mkdir -p ~/Sources/github.com/yujinyuz
$ cd Sources/github.com/yujinyuz
$ git clone git@github.com:yujinyuz/dotfiles.git
$ ./syncdots
```

## Update Brewfile
```
$ brew bundle dump --file=macos/Brewfile --force
```

## Install FZF Completions
```
/opt/homebrew/opt/fzf/install --no-bash --no-zsh --no-update-rc --key-bindings --completion
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

## nvim finder

```fish
set -Ux NVIM_FILE_FINDER fzf # choices: fzf, telescope
```


## tmux

```fish
set -Ux BG_TMUX "#1F1F28"  # Depending on current theme
```

## asdf

Install asdf
Install direnv

```bash
asdf plugin-add direnv
asdf direnv setup --shell fish --version system
```

## python

Install virtualfish

```bash
pipx install virtualfish
vf install
vf addplugins auto_activation
```

Creating a virtualenv

```bash
vf new -p /path/to/python <venv_name> # or vf new -p 3.x venv_name
```

> (Optional): For every repository, create an `exports.fish` file for environments you want to export.
> This is done using this fish-shell plugin: https://github.com/yujinyuz/tackle

### pipx binaries

```
pre-commit
autopep8
flake8
black
reorder-python-imports
codespell
```

```fish
# filename: /path/to/repo/exports.fish
set -gx DJANGO_SETTINGS_MODULE ...
```

## ghq

Using ghq with a custom `.gitconfig` that uses a different `core.sshCommand` almost always doesn't work during a fresh install because it only works when you are inside a git repository.

Using this example repository URL: git@github.com:abc/software.git

One hack I do is that I would manually create a the folder where `ghq` will clone it

```bash
mkdir -p /ghq/sources/abc/software
```

then make `abc` as a pseudo git repository just so that a custom gitconfig works

```
cd /ghq/sources/abc
git init
```
