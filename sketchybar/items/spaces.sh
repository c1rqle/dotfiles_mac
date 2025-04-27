#!/bin/bash


  SPACE_SIDS=(1 2 3 4 5 6 7 8 9)
  sid=0
  spaces=(0)
  for i in "${!SPACE_SIDS[@]}"
  do
    sid=$(($i+1)) 
  for sid in "${SPACE_SIDS[@]}"

  do
  sketchybar --add space space.$sid left                        \
             --set space.$sid space=$sid                        \
                icon=$sid                                       \
                label.font="sketchybar-app-font:Regular:14.0"   \
                label.padding_right=20                          \
                label.y_offset=-1                               \
                label.color=$mint_30                            \
                icon.color=$mint_30                             \
                icon.highlight_color="$purple_100"              \
                label.highlight_color="$purple_100" 
                script="$PLUGIN_DIR/space.sh" 
  done

  sketchybar --add item space_separator left                    \
             --set space_separator icon="􀆊"                     \
                icon.color=$purple_60                           \
                icon.padding_left=0                             \
                icon.padding_right=4                            \
                label.drawing=off                               \
                background.drawing=off                          \
                script="$PLUGIN_DIR/space_windows.sh"           \
              --subscribe space_separator space_windows_change

#_______________________________________
# Destroy space on right click, focus space on left click.  New space by left clicking separator (>)
  sketchybar --add space space.$sid left                        \
             --set space.$sid "${space[@]}"                     \
             --subscribe space.$sid mouse.clicked
  done
  
  space_creator=(                                               \
      icon.font="$FONT_TEXT:Regular:16.0"                       \
      padding_left=10                                           \
      padding_right=0                                           \
      label.drawing=on                                          \
      display=active                                            \
      click_script='yabai -m space --create'                    \
      script="$PLUGIN_DIR/space_windows.sh"                     \
      script="$PLUGIN_DIR/space.sh"
  )
  

  sketchybar --add item space_creator left                      \
             --set space_creator "${space_creator[@]}"          \
             --subscribe space_creator space_windows_change
