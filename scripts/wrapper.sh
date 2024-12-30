#!/bin/bash

MONITORS_SCRIPT="$HOME/scripts/monitors.sh"

if [ "$BLOCK_BUTTON" = "1" ]; then
  # Execute the monitors.sh script
  bash "$MONITORS_SCRIPT"
fi
