# dotdotdot
My collection of dotfiles using git bare

## Setup
```sh
git init --bare $HOME/.dotfiles
alias config='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
config remote add origin git@github.com:yujinyuz/dotfiles.git
```

## Setting up a new machine
```sh
git clone --separate-git-dir=$HOME/.dotfiles https://github.com/yujinyuz/dotfiles.git dotfiles-tmp
rsync --recursive --verbose --exclude '.git' dotfiles-tmp/ $HOME/
rm --recursive dotfiles-tmp
```

## Configuration
```sh
config config status.showUntrackedFiles no
config remote set-url origin git@github.com:yujinyuz/dotfiles.git
```

## Usage
```sh
config status
config add .gitconfig
config commit -m 'Add gitconfig'
config push
```
