#!/bin/bash

sketchybar --add item cpu right \
           --set cpu  update_freq=2 \
           label.font="OperatorMono Nerd Font:BoldItalic:16.0"   \
                      icon=􀧓  \
                      script="$PLUGIN_DIR/cpu.sh"
