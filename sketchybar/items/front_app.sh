#!/bin/bash

sketchybar --add item front_app left                                            \
           --set front_app       background.color=$transparent_color            \
                                 icon.font="sketchybar-app-font:Regular:14.0"   \
                                 label.font="$FONT_TEXT:BoldItalic:16.0"        \
                                 icon.color=$purple_60                          \
                                 label.color=$purple_60                         \
                                 script="$PLUGIN_DIR/front_app.sh"              \
           --subscribe front_app front_app_switched
