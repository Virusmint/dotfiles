#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/utils.sh"
eval "$(parse_yaml "$SCRIPT_DIR/config.yaml" "CONFIG_")"
CURRENT_COURSE_TARGET=$(readlink -f "$CONFIG_CURRENT_COURSE_SYMLINK") || exit 1

main() {
  pushd "$CONFIG_TARGET_DIR" >/dev/null || exit 1

  course_paths=()
  options=()
  i=0
  current_course_index=-1
  for dir in */; do
    if [[ -d "$dir" && -f "$dir/info.yaml" ]]; then
      eval "$(parse_yaml "$dir/info.yaml" "course_")"
      if [[ -n "$course_title" ]]; then
        course_paths+=("$dir")
        options+=("$course_title")
        if [[ "$CURRENT_COURSE_TARGET/" == "$CONFIG_TARGET_DIR/$dir" ]]; then
          current_course_index=$i
        fi
        ((i++))
      fi
    fi
  done

  popd >/dev/null || exit 1

  ROFI_DMENU_ARGS=(
    -i
    -format i
    -theme-str 'entry {placeholder: "Search Course...";}'
    -l ${#options[@]}
    -a "$current_course_index"
    -selected-row "$current_course_index"
  )

  selected_index=$(printf "%s\n" "${options[@]}" | rofi_dmenu "${ROFI_DMENU_ARGS[@]}")
  if [[ -z "$selected_index" ]] || [[ "$selected_index" == "-1" ]]; then
    echo "Error: Invalid selection."
    exit 0
  fi
  course_path=${course_paths[$selected_index]}

  ln -sfn "$CONFIG_TARGET_DIR/$course_path" "$CONFIG_CURRENT_COURSE_SYMLINK"
}

main "$@"
