#!/usr/bin/env bash

COLOR="$WHITE"

sketchybar \
	--add item front_app left \
	--set front_app script="$PLUGIN_DIR/front_app.sh" \
	icon.drawing=off \
	background.height=26 \
	background.padding_left=0 \
	background.padding_right=10 \
	background.border_width="$BORDER_WIDTH" \
	background.border_color="$RED_DARK" \
	background.corner_radius="$CORNER_RADIUS" \
	background.color="$purple_10" \
  label.color="$DARK_BLUE" \
	label.padding_left=15 \
	label.padding_right=15 \
	associated_display=active \
	--subscribe front_app front_app_switched
