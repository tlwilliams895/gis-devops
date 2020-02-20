#! /usr/bin/env bash

target_dir="$(pwd)/src/weeks"

run() {
  read -p "enter the week number (2 digits, ex: for week 1 enter 01): " week_number
  week_file="${target_dir}/week${week_number}.rst"

  read -p "enter the week's theme title: " week_title
  
# TODO: list topics and allow selection, auto generate ref
  read -p "enter the day 1 theme title: " day1_title
  read -p "enter the day 2 theme title: " day2_title
  read -p "enter the day 3 theme title: " day3_title
  read -p "enter the day 4 theme title: " day4_title
  read -p "enter the day 5 theme title: " day5_title
  
  declare -a day_titles=("$day1_title" "$day2_title" "$day3_title" "$day4_title" "$day5_title")

  create_week_file
}

create_week_file() {
  if [[ -e $week_file ]]; then
    echo "week file already exists"
    echo "appending .bak to existing file [${week_file}]"
    mv "$week_file" "${week_file}.bak"
  fi

  cat << EOF > "$week_file"
.. _week${week_number}:

$(print_page_header "Week ${week_number}: ${week_title}")
$(print_day_sections)
EOF
}

print_day_sections() {
  for day_index in "${!day_titles[@]}"
  do
    day_number="$(($day_index + 1))" # 0 based
    echo "$(cat << EOF
$(print_section_header "Day ${day_number}: ${day_titles[$day_index]}")
 
EOF
    )"
  done
}

print_page_header() {
  echo "$(cat << EOF
$(print_header_border "$1")
${1}
$(print_header_border "$1")
 
EOF
  )"
}

print_section_header() {
  echo "$(cat << EOF
${1}
$(print_header_border "$1" '-')

- 
EOF
  )"
}

# TODO: move to shared "create-x" utils
print_header_border() {
  file_header_length="${#1}"
  border_symbol="${2:-=}" # default to '=' char

  printf -- "$border_symbol"'%.0s' $(seq $file_header_length)
}

run