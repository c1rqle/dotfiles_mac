#!/bin/sh

  source "$CONFIG_DIR/colors.sh"
 
  sketchybar --add bracket spaces space.1 space.2 space.3 space.4 space.5 space.6 space.7 space.8 space.9  \
             --set         spaces background.color=$BG_1 \
                           background.corner_radius=4  \
                           background.height=23 \
                           label.color=$mint_100 
  
  sketchybar --set $NAME icon.highlight=$MINT_100 \
                           label.highlight=$MINT_100 \
                           background.border_color=$MINT_30


  set_space_label() {
    if [ "$SELECTED" = "true" ]; then 
      icon.color=$PURPLE_100
      label.color=$PURPLE_100
    fi
    sketchybar --set $NAME icon="$@"
    icon.color=$PURPLE_100
  }

  mouse_clicked() {
    if [ "$BUTTON" = "right" ]; then
      yabai -m space --destroy $SID
    else
      if [ "$MODIFIER" = "shift" ]; then
        SPACE_LABEL="$(osascript -e "return (text returned of (display dialog \"Give a name to space $NAME:\" default answer \"\" with icon note buttons {\"Cancel\", \"Continue\"} default button \"Continue\"))")"
        if [ $? -eq 0 ]; then
          if [ "$SPACE_LABEL" = "" ]; then
            set_space_label "${NAME:6}"
          else
            set_space_label "${NAME:6} ($SPACE_LABEL)"
          fi
        fi
      else
        yabai -m space --focus $SID 2>/dev/null
      fi
    fi
  }
 
  case "$SENDER" in
    "mouse.clicked") mouse_clicked
    ;;
    *) update
    ;;
  esac
