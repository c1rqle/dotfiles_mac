#!/bin/bash

sketchybar --add item calendar right                                              \
           --set calendar icon=                                                  \
                          update_freq=30                                          \
                          label.font="OperatorMono Nerd Font:BookItalic:16.0"   \
                          padding_left=20                                      \
                          padding_right=0                                     \
                          icon.padding_right=0                                    \
                          label.padding_right=0                                   \
                          label.y_offset=0                                   \
                          label.color="$MINT_100"                                 \
                          script="$PLUGIN_DIR/calendar.sh"
