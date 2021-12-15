# tmux


There's a problem with `htop` where I don't see colors when TERM=tmux-256color: https://github.com/htop-dev/htop/issues/251


Let's just use the terminfo provided by tmux maintainers and load it up:

```
curl -O https://gist.githubusercontent.com/nicm/ea9cf3c93f22e0246ec858122d9abea1/raw/37ae29fc86e88b48dbc8a674478ad3e7a009f357/tmux-256color
/usr/bin/tic -xe tmux-256color
```

Alternatively, we could also run this command since we are using alacritty and we added the correct terminfo in our repository

```
/usr/bin/tic -xe alacritty,tmux-256color tmux-256color.src
```

