#!/bin/bash

MONITORS=$(xrandr | grep " connected" | awk '{print $1}')

RESOLUTIONS=$(xrandr | grep -A1 "${MONITORS}" | grep '*' | awk '{print $1}')
ADAPTERS=$(xrandr | grep ' connected' | cut -d ' ' -f 1)

MODES=("Single Screen" "Duplicate" "Extend")

POSITIONS=("right-of" "left-of" "above" "bottom")

SELECTED_MODE=$(printf "%s\n" "${MODES[@]}" | rofi -dmenu -p "Select Display Mode:")
SELECTED_ADAPTER=$(echo "$ADAPTERS" | rofi -dmenu -p "Select Adapter:")

FIRST_RESOLUTION=$(xrandr | grep -A1000 "$SELECTED_ADAPTER" | grep -E "^\s" | cut -d $' ' -f4)
SELECTED_RESOLUTION=$(echo "$FIRST_RESOLUTION" | rofi -dmenu -p "Select Resolution")

FIRST_RATE=$(xrandr | grep -A1000 "$SELECTED_ADAPTER" | grep -E "^\s" | grep "$SELECTED_RESOLUTION" | awk '{for(i=2;i<=NF;i++) print $i}' | sed 's/*//g' | sed 's/+//g' | uniq)
SELECTED_RATE=$(echo "$FIRST_RATE" | rofi -dmenu -p "Select Refresh Rate:")

#Main Screen Only
if [ "$SELECTED_MODE" == "Single Screen" ]; then
  xrandr --output $SELECTED_ADAPTER --mode $SELECTED_RESOLUTION --rate $SELECTED_RATE --primary
  for output in $(xrandr | grep " connected" | awk '{print $1}' | grep -v "$SELECTED_ADAPTER"); do
    xrandr --output "$output" --off
  done
elif [ "$SELECTED_MODE" == "Duplicate" ]; then
  for output in $(xrandr | grep " connected" | awk '{print $1}'); do
    xrandr --output "$output" --auto
  done
  SECOND_ADAPTER=$(echo "$ADAPTERS" | grep -v $SELECTED_ADAPTER | rofi -dmenu -p "Select Second Adapter:")
  xrandr --output $SELECTED_ADAPTER --mode $SELECTED_RESOLUTION --rate $SELECTED_RATE --output $SECOND_ADAPTER --same-as $SELECTED_ADAPTER
else
  SELECTED_SECOND_ADAPTER=$(echo "$ADAPTERS" | grep -v $SELECTED_ADAPTER | rofi -dmenu -p "Select Second Adapter:")

  SECOND_RESOLUTION=$(xrandr | grep -A1000 "$SELECTED_SECOND_ADAPTER" | grep -E "^\s" | cut -d $' ' -f4)
  SELECTED_SECOND_RESOLUTION=$(echo "$SECOND_RESOLUTION" | rofi -dmenu -p "Select Resolution for Second Screen:")

  SECOND_RATE=$(xrandr | grep -A1000 "$SECOND_ADAPTER" | grep -E "^\s" | grep "$SELECTED_RESOLUTION" | awk '{for(i=2;i<=NF;i++) print $i}' | sed 's/*//g' | sed 's/+//g' | uniq)
  SELECTED_SECOND_RATE=$(echo "$SECOND_RATE" | rofi -dmenu -p "Select Rate for Second Screen:")

  SELECTED_POSITION=$(printf "%s\n" "${POSITIONS[@]}" | rofi -dmenu -p "Select Position of Second Screen:")

  xrandr --output SELECTED_ADAPTER --mode $SELECTED_RESOLUTION --rate $SELECTED_RATE --output $SELECTED_SECOND_ADAPTER --mode $SELECTED_SECOND_RESOLUTION --rate $SELECTED_SECOND_RATE --$SELECTED_POSITION $SELECTED_ADAPTER
fi
