#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/utils.sh"
eval "$(parse_yaml "$SCRIPT_DIR/config.yaml" "CONFIG_")"
CURRENT_COURSE_TARGET=$(readlink -f "$CONFIG_CURRENT_COURSE_SYMLINK")

create_new_lecture() {
  local current_date
  current_date=$(date +%Y-%m-%d)
  local new_lecture_number
  local new_lecture_title
  local new_lecture_path

  if [[ $num_lectures -eq 0 ]]; then
    new_lecture_number=1
    cp "$CONFIG_ROOT_DIR/templates/master.tex" "$CURRENT_COURSE_TARGET/master.tex"
  else
    last_lecture_number=$(basename "${lecture_paths[1]}" | grep -oE '[0-9]+')
    new_lecture_number=$((last_lecture_number + 1))
  fi
  new_lecture_path="$CURRENT_COURSE_TARGET/lec_$(printf "%02d" "$new_lecture_number").tex"
  new_lecture_title=$(
    rofi_dmenu \
      -p "Lecture Title: " \
      -l 0 \
      -theme-str "entry {placeholder: \"Enter Lecture Title\";}" \
      -theme-str "textbox-prompt-colon {str: \"🗎\";}"
  ) || return 1
  if [[ -z "$new_lecture_title" ]]; then
    new_lecture_title="Lecture $new_lecture_number"
  fi
  echo "% ! TeX root = ./master.tex" >"$new_lecture_path"
  echo "\\lecture{$new_lecture_number}{$current_date}{$new_lecture_title}" >>"$new_lecture_path"
  echo "$new_lecture_path"
}

nvim_lecture() {
  local lecture_path="$1"
  if lsof -U "$CONFIG_NVIM_SOCKET_PATH" &>/dev/null; then
    nvim --server "$CONFIG_NVIM_SOCKET_PATH" --remote "$lecture_path" &>/dev/null &
  else
    kitty nvim --listen "$CONFIG_NVIM_SOCKET_PATH" "$lecture_path" &>/dev/null &
  fi
}

main() {
  pushd "$CURRENT_COURSE_TARGET" >/dev/null || exit 1
  mapfile -t lecture_paths < <(
    printf "%s\n" "NA"
    find ~+ -type f -name 'lec_*.tex' | sort -r
  )
  echo "$lecture_paths"
  num_lectures=$((${#lecture_paths[@]} - 1))

  rofi_options=("(+) <b>New Lecture</b>")
  for lecture_path in "${lecture_paths[@]:1}"; do
    read -r lecture_number lecture_date lecture_title < <(
      gawk '
    match($0, /^\\lecture\{([0-9]+)\}\{(.+?)\}\{(.*?)\}$/, a) {
        print a[1], a[2], a[3]
        exit
    }' "$lecture_path"
    )
    option=$(
      printf "%2s. <b>%-*s</b> <span size='smaller'>%s</span>\n" \
        "$lecture_number" \
        "$CONFIG_LECTURE_TITLE_MAX_WIDTH" \
        "$(truncate_string "$lecture_title" "$CONFIG_LECTURE_TITLE_MAX_WIDTH")" \
        "$lecture_date"
    )
    rofi_options+=("$option")
  done

  ROFI_DMENU_ARGS=(
    -i
    -markup-rows
    -format i
    -theme-str "entry {placeholder: \"Search Lecture in $(basename "$CURRENT_COURSE_TARGET")/... \";}"
    -l ${#rofi_options[@]}
  )
  selected_index=$(printf "%s\n" "${rofi_options[@]}" | rofi_dmenu "${ROFI_DMENU_ARGS[@]}") || exit 1
  case "$selected_index" in
  0) selected_lecture_path=$(create_new_lecture) || exit 1 ;;
  *) selected_lecture_path="${lecture_paths[$selected_index]}" ;;
  esac
  nvim_lecture "$selected_lecture_path"

  popd >/dev/null || exit 1
}

main "$@"
