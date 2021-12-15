#!/usr/bin/env bash

set -e




  # Status Bar
tmux set-option -g status-style "fg=#3e7de9,bg=#d4d6e4"
tmux set-option -g status-left "#[fg=#e9e9ed,bg=#2e7de9] #S #[fg=#2e7de9,bg=#d4d6e4,nobold,nounderscore,noitalics]"

# Window
tmux set-option -g window-status-format "#[fg=#d4d6e4,bg=#d4d6e4,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#d4d6e4,bg=#d4d6e4,nobold,nounderscore,noitalics]"
tmux set-option -g window-status-current-format "#[fg=#d4d6e4,bg=#a8aecb,nobold,nounderscore,noitalics]#[fg=#2e7de9,bg=#a8aecb,bold] #I  #W #F #[fg=#a8aecb,bg=#d4d6e4,nobold,nounderscore,noitalics]"
tmux set-option -g window-status-activity-style "fg=#3e7de9,bg=#d4d6e4"

# Panes
tmux set-option -g pane-border-style "fg=#a8aecb"
tmux set-option -g pane-active-border-style "fg=#2e7de9"

# Message
tmux set-option -g message-style "fg=#2e7de9,bg=#a8aecb"
tmux set-option -g message-command-style "fg=#2e7de9,bg=#a8aecb"

# Mode
tmux set-option -g mode-style "fg=#2e7de9,bg=#a8aecb"

