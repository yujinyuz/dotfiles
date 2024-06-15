#!/usr/bin/env bash

sketchybar --add item front_app left \
           --set front_app       background.color=$GREY \
                                 icon.color=$BAR_COLOR \
                                 icon.font="sketchybar-app-font:Regular:16.0" \
                                 label.color=$BAR_COLOR \
                                 script="$PLUGIN_DIR/front_app.sh"            \
           --subscribe front_app front_app_switched
