#!/bin/sh

# The $SELECTED variable is available for space components and indicates if
# the space invoking this script (with name: $NAME) is currently selected:
# https://felixkratz.github.io/SketchyBar/config/components#space----associate-mission-control-spaces-with-an-item

source "$CONFIG_DIR/colors.sh"

#if [ $SELECTED = true ]; then                            
#  sketchybar --set $NAME background.drawing=on                   
#                         background.color=$MINT_100             
#                         label.color=$PURPLE_100                  
#                         icon.color=$PURPLE_100                   
#
#else                                                            
#  sketchybar --set $NAME background.drawing=off                 
#                         label.color=$MINT_80                   
#                         icon.color=$PURPLE_100                  
#fi

#\
#\
#\
#\
#\
#\
  sketchybar --set $NAME icon.highlight=$MINT_100
  sketchybar --add bracket spaces space.1 space.2 space.3 space.4 space.5 space.6 space.7 space.8 space.9    \
             --set         spaces background.color=$BRACK_BG_1 \
                                background.corner_radius=4  \
                                background.height=23 \
                                label.color=$MINT_100


#                             spaces label.color=0xff3F103C \
#                           spaces icon.color=$DARK_COLOR \
#
