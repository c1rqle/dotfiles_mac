#!/bin/bash
#label.font="sketchybar-app-font:Regular:15.0" \
 
  SPACE_SIDS=(1 2 3 4 5 6 7 8 10)

  source "$CONFIG_DIR/colors.sh"

  for sid in "${SPACE_SIDS[@]}"
  do
    sketchybar --add space space.$sid left                                    \
               --set space.$sid space=$sid                                    \
                                icon=$sid                                     \
                                icon.color=$PURPLE_100                        \
                                label.font="OperatorMono Nerd Font:Bold:15.0"     \
                                icon.font="OperatorMono Nerd Font:Bold:16.0"     \
                                label.padding_right=15                        \
                                label.y_offset=-1                             \
                                script="$PLUGIN_DIR/space.sh"                 \
                                click_script="yabai -m space --focus $sid" 
  done
  
  sketchybar --add item space_separator left                                  \
             --set space_separator icon="→"                                   \
                                   icon.color=$MINT_100                       \
                                   icon.padding_left=4                        \
                                   label.drawing=off                          \
                                   background.drawing=on                      \
                                   script="$PLUGIN_DIR/space_windows.sh"      \
             --subscribe space_separator space_windows_change
