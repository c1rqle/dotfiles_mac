#!/bin/bash

sketchybar --add item battery right \
           --set battery update_freq=120 \
           label.font="OperatorMono Nerd Font:BoldItalic:16.0"   \
           padding_left=20                                        \
                         script="$PLUGIN_DIR/battery.sh" \
           --subscribe battery system_woke power_source_change
