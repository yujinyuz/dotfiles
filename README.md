# dotfiles
My collection of dotfiles

Days since last changed: `0`

## Setup


Currently playing around with `chezmoi`.
WIP.

```shell
export GITHUB_USERNAME="<your-username>"
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME

# OR

sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply username/dotfiles-x

```
