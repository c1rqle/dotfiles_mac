#!/bin/bash

sketchybar --add item front_app left \
           --set front_app       background.color=$TRANSPARENT_COLOR                   \
                                 background.corner_radius=5                            \
                                 icon.font="sketchybar-app-font:Regular:16.0"          \
                                 label.font="OperatorMono Nerd Font:MediumItalic:16.0"   \
                                 label.color=$MINT_100                                  \
                                 icon.color=$MINT_80                                   \
                                 script="$PLUGIN_DIR/front_app.sh"                     \
           --subscribe front_app front_app_switched
