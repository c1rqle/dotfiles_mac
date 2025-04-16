#!/bin/bash

  source "$CONFIG_DIR/colors.sh"

  sketchybar --add item weekday right                                               \
             --set weekday icon=                                                    \
                            update_freq=30                                        \
                            label.font="OperatorMono Nerd Font:MediumItalic:17.0"   \
                            icon.padding_left=0                                   \
                            padding_left=-75                               \
                            label.padding_left=0                                  \
                            label.y_offset=6                                   \
                            background.height=20                                \
                            label.color="$MINT_100"                             \
                            script="$PLUGIN_DIR/weekday.sh"
