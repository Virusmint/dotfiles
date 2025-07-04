#!/usr/bin/bash

ROFI_DMENU_THEME="$HOME/.config/rofi/dmenu/style.rasi"
function rofi_dmenu {
  local rofi_args=("$@")
  if [[ -f "$ROFI_DMENU_THEME" ]]; then
    rofi_args+=("-theme" "$ROFI_DMENU_THEME")
  fi
  rofi \
    -dmenu \
    "${rofi_args[@]}"
}

# https://stackoverflow.com/questions/5014632/how-can-i-parse-a-yaml-file-from-a-linux-shell-script
function parse_yaml {
  local prefix=$2
  local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo @ | tr @ '\034')
  sed -ne "s|^\($s\):|\1|" \
    -e "s|^\($s\)\($w\)$s:$s[\"']\(.*\)[\"']$s\$|\1$fs\2$fs\3|p" \
    -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p" $1 |
    awk -F$fs '{
      indent = length($1)/2;
      vname[indent] = $2;
      for (i in vname) {if (i > indent) {delete vname[i]}}
      if (length($3) > 0) {
         vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
         printf("%s%s%s=\"%s\"\n", "'$prefix'",vn, $2, $3);
      }
   }'
}

function truncate_string {
  local str="$1"
  local max_length="$2"
  if [[ ${#str} -gt $max_length ]]; then
    echo "${str:0:max_length-4} ... "
  else
    echo "$str"
  fi
}
