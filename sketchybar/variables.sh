#!/usr/bin/env sh

# ______________________
# borders= 
#   rgba(249, 159, 175, 0.35) | #f99faf59
# per item backgrounds: 
#   rgba(0,0,0,.55) | #0000008c
# standard color: 
#   rgba(251, 197, 207, 1) | #fbc5cf
# highlight color: 
# rgb(247, 141, 160, .99) | #f78da0
#
  BORDERS=0xf99faf59
  ITEM_BG=0x0000008c
  COLOR_TXT=0xfbc5cffc
  COLOR_HGHLGHT=0xf78da0fc

  BLACK=0xff24283b
  WHITE=0xffa9b1d6
  MAGENTA=0xffbb9af7
  BLUE=0xff7aa2f7
  CYAN=0xff7dcfff
  GREEN=0xff9ece6a
  YELLOW=0xffe0af68
  ORANGE=0xffff9e64
  RED=0xfff7768e
  RED_DARK1=0xccf7768e
  RED_DARK2=0x80f7768e
  RED_DARK=0x40f7768e
  BAR_COLOR=$transparent_color
  COMMENT=0xff565f89
  #DARK_BLUE=0xff8e96b8
  DARK_BLUE=0xffb4b9d0
  
  TRANSPARENT=0x00000000
  
  # General bar colors
  ICON_COLOR=$RED_DARK1  
  LABEL_COLOR=$DARK_BLUE # Color of all labels
  
  ITEM_DIR="$HOME/.config/sketchybar/items"
  PLUGIN_DIR="$HOME/.config/sketchybar/plugins"
  
  FONT="OperatorMono Nerd Font" 
  
  PADDINGS=3
  
  POPUP_BORDER_WIDTH=2
  POPUP_CORNER_RADIUS=11
  POPUP_BACKGROUND_COLOR=$BLACK
  POPUP_BORDER_COLOR=$COMMENT
  
  CORNER_RADIUS=15
  BORDER_WIDTH=2
  
  SHADOW=on
  
  SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9")
