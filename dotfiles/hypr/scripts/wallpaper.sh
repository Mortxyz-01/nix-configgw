#!/usr/bin/env bash

WALL=$(ls ~/Pictures/wallpapers | rofi -dmenu -p "Select wallpaper")

if [ -n "$WALL" ]; then
  swww img ~/Pictures/wallpapers/$WALL \
    --transition-type grow \
    --transition-duration 1
fi