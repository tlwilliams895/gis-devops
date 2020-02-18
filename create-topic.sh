#! /usr/bin/env bash

target_path="$(pwd)/src/topics"

run() {
  read -p "enter the topic name (use dashes not spaces): " topic_name

  topic_dir="${target_path}/${topic_name}"

  mkdir "$topic_dir"

  create_topic_files
}

create_topic_files() {
  create_index_file

  create_objectives_file

  declare -a file_types=(walkthrough studio)
  for file_type in "${file_types[@]}"
  do
    create_topic_file $file_type
  done
}

create_index_file() {
  create_topic_file index

  cat << EOF >> "$(get_topic_file_path index)"
$(build_ref objectives) for this module

Lesson Content
==============

- 

Walkthrough
===========

- $(build_ref walkthrough)

Studio
======

- $(build_ref studio)

Resources
=========

-
EOF
}

create_objectives_file() {
  create_topic_file objectives 'Learning Objectives'

  cat << EOF >> "$(get_topic_file_path objectives)"
Conceptual
----------

-

Practical
---------

-

EOF
}

create_topic_file() {
  file_type="$1"

  file_header="$2"

  if [[ -z $file_header ]]; then
    IFS= read -p "enter the header for the ${file_type} doc: " file_header
  fi

  cat << EOF > "$(get_topic_file_path $file_type)"
:orphan:

.. _${topic_name}_${file_type}:

$(print_header_border "$file_header")
${file_header}
$(print_header_border "$file_header")

EOF
}

get_topic_file_path() {
  echo "${topic_dir}/${1}.rst"
}

build_ref() {
  echo ":ref:\`${topic_name}_${1}\`"
}

print_header_border() {
  file_header_length="${#1}"

  printf '=%.0s' $(seq $file_header_length)
}

run
