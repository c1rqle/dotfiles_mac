#!/usr/bin/env bash

  SPOTIFY_EVENT="com.spotify.client.PlaybackStateChanged"
  POPUP_SCRIPT="sketchybar -m --set \$NAME popup.drawing=toggle"

sketchybar --add       event           spotify_change $SPOTIFY_EVENT              \
           --add       item            spotify.name center                        \
           --set       spotify.name    click_script="$POPUP_SCRIPT"               \
                                       label.font="$FONT_TEXT:BoldItalic:14.0"    \
                                       background.height=26                       \
                                       background.color="$purple_10"              \
                                       background.border_width="$BORDER_WIDTH"    \
                                       background.border_color="$RED_DARK"        \
                                       background.corner_radius="$CORNER_RADIUS"  \
                                       background.padding_left=15                 \
                                       background.padding_right=15                \
                                       label.padding_left=15                      \
                                       label.padding_right=15                     \
                                       popup.horizontal=on                        \
                                       popup.align=center                         \
                                       icon.drawing=off                           \
                                                                                  \
           --add       item            spotify.back popup.spotify.name            \
           --set       spotify.back    icon=􀊎                                     \
                                       icon.padding_left=25                       \
                                       icon.padding_right=8                       \
                                       script="$PLUGIN_DIR/spotify.sh"            \
                                       label.drawing=off                          \
           --subscribe spotify.back    mouse.clicked                              \
                                                                                  \
           --add       item            spotify.play popup.spotify.name            \
           --set       spotify.play    icon=􀊔                                     \
                                       icon.padding_left=8                        \
                                       icon.padding_right=8                       \
                                       updates=on                                 \
                                       label.drawing=off                          \
                                       script="$PLUGIN_DIR/spotify.sh"            \
           --subscribe spotify.play    mouse.clicked spotify_change               \
                                                                                  \
           --add       item            spotify.next popup.spotify.name            \
           --set       spotify.next    icon=􀊐                                     \
                                       icon.padding_left=8                        \
                                       icon.padding_right=8                       \
                                       label.drawing=off                          \
                                       script="$PLUGIN_DIR/spotify.sh"            \
           --subscribe spotify.next    mouse.clicked                              \
                                                                                  \
           --add       item            spotify.shuffle popup.spotify.name         \
           --set       spotify.shuffle icon=􀊝                                     \
                                       icon.highlight_color=0xff1DB954            \
                                       icon.padding_left=8                        \
                                       icon.padding_right=8                       \
                                       label.drawing=off                          \
                                       script="$PLUGIN_DIR/spotify.sh"            \
           --subscribe spotify.shuffle mouse.clicked                              \
                                                                                  \
           --add       item            spotify.repeat popup.spotify.name          \
           --set       spotify.repeat  icon=􀊞                                     \
                                       icon.highlight_color=0xff1DB954            \
                                       icon.padding_left=8                        \
                                       icon.padding_right=25                      \
                                       label.drawing=off                          \
                                       script="$PLUGIN_DIR/spotify.sh"            \
           --subscribe spotify.repeat  mouse.clicked
