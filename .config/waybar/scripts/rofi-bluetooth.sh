#!/bin/bash

MAX_LEN=40

# Get devices from bluetoothctl
mapfile -t mac_addresses < <(bluetoothctl devices | cut -d ' ' -f 2)
mapfile -t device_names < <(bluetoothctl devices | cut -d ' ' -f 3-)
display_list=()

# Get display options
for i in "${!device_names[@]}"; do
  raw_name="${device_names[$i]}"

  # Truncate if too long
  if [ ${#raw_name} -gt $MAX_LEN ]; then
    display_name="${raw_name:0:$((MAX_LEN - 3))}..."
  else
    display_name=$raw_name
  fi

  # Get device connection status
  if bluetoothctl info "${mac_addresses[$i]}" | grep -q "Connected: yes"; then
    status="󰂱"
  else
    status=" "

  fi
  display_list[i]="$status ${display_name}"
done

# Rofi device selection
rofi_dmenu_args=(
  -i
  -format i
  -theme-str 'entry {placeholder: "Search Bluetooth Device...";}'
)
selected_index=$(printf "%s\n" "${display_list[@]}" | rofi-dmenu "${rofi_dmenu_args[@]}")
if [ -z "$selected_index" ]; then
  exit 1
fi

# Connect/Disconnect
target_mac="${mac_addresses[$selected_index]}"
target_name="${device_names[$selected_index]}"
# Check status again
if bluetoothctl info "$target_mac" | grep -q "Connected: yes"; then
  output=$(bluetoothctl disconnect "$target_mac" 2>&1 | tail -n 1)
else
  output=$(bluetoothctl connect "$target_mac" 2>&1 | tail -n 1)
fi
notify-send "Bluetoothctl" "$output: $target_name"
