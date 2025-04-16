#!/bin/bash

sketchybar --add item volume right \
           --set volume script="$PLUGIN_DIR/volume.sh" \
           label.font="OperatorMono Nerd Font:BoldItalic:16.0"   \
           padding_left=20      \                                  \
           --subscribe volume volume_change \
