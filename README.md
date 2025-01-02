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

Current tide config

To see this, you need to go through `tide configure` and then choose `(p) Exit and print the config you just generated`


Verbose
```fish
tide configure --auto --style=Lean --prompt_colors='True color' --show_time='24-hour format' --lean_prompt_height='Two lines' --prompt_connection=Disconnected --prompt_spacing=Compact --icons='Many icons' --transient=No
```

Simple One Line no icons
```fish
tide configure --auto --style=Lean --prompt_colors='True color' --show_time='24-hour format' --lean_prompt_height='One line' --prompt_spacing=Compact --icons='Few icons' --transient=No
set -U tide_prompt_min_cols 512  # Always truncate path
set --prepend tide_right_prompt_items shlvl

_tide_find_and_remove os $tide_left_prompt_items
set -U tide_git_icon
```



```
❯ echo $tide_right_prompt_items
status cmd_duration context jobs direnv bun node python rustc java php pulumi ruby go gcloud kubectl distrobox toolbox terraform aws nix_shell crystal elixir zig time

❯ echo $tide_left_prompt_items
pwd git character
```


### hydro
set -Ux hydro_color_pwd 00AFFF
set -Ux hydro_color_git 5FD700
set -Ux hydro_color_prompt --dim 5FD700
set -Ux hydro_color_duration --dim $fish_color_normal
set -Ux hydro_symbol_prompt ❯




set -Ux DOCKER_HOST unix:///Users/$USER/Library/Containers/com.docker.docker/Data/docker.raw.sock
