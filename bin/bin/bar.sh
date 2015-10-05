#!/usr/bin/env bash

Battery() {
  BATTERY_PERCENTAGE=$(acpi --battery | cut -d, -f2)
  echo "$BATTERY_PERCENTAGE" | tr -d '\n' | tr -d '%'
}

while true; do
  echo "$(Battery)"
  sleep 1;
done
