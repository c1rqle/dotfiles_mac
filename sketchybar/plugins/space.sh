#!/bin/sh

  update() {
    if [ "$SELECTED" = "true" ]; then
      sketchybar -m --set $SPACE_SIDS label.highlight=on icon.highlight=on background.drawing=on
    else
      sketchybar -m --set $SPACE_SIDS label.highlight=off icon.highlight=off background.drawing=off
    fi
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
