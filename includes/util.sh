#!/usr/bin/env bash

function toolbox_util_array_join() {
  local IFS=" "; echo "$*";
}

function toolbox_util_read_var_from_env_file() {
   VAR=$(grep -w "$1" "$2" | xargs)
   IFS="=" read -ra VAR <<< "$VAR"
   set +u
   echo "${VAR[1]}"
   set -u
}

