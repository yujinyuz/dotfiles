#!/usr/bin/env bash

set -e

# Status Bar
tmux set-option -g status-style "fg=#7aa2f7,bg=#1f2335"

# Window
tmux set-option -g window-status-format "#[fg=#1f2335,bg=#1f2335,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#1f2335,bg=#1f2335,nobold,nounderscore,noitalics]"
tmux set-option -g window-status-current-format "#[fg=#1f2335,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#3b4261,bold] #I  #W #F #[fg=#3b4261,bg=#1f2335,nobold,nounderscore,noitalics]"
tmux set-option -g window-status-activity-style "fg=#7aa2f7,bg=#1f2335"


# Panes
tmux set-option -g pane-border-style "fg=#3b4261"
tmux set-option -g pane-active-border-style "fg=#7aa2f7"

# Message bar
tmux set-option -g message-style "fg=#7aa2f7,bg=#3b4261"
tmux set-option -g message-command-style "fg=#7aa2f7,bg=#3b4261"

# Mode
tmux set-option -g mode-style "fg=#7aa2f7,bg=#3b4261"
