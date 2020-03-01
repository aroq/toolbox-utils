#!/usr/bin/env bash

TOOLBOX_EXEC_LOG_PREFIX=${TOOLBOX_EXEC_LOG_PREFIX-"---> "}

function _toolbox_exec_log() {
  local title
  title=${1:-"Execute command"}

  shift

  local args
  args=$(toolbox_util_array_join "$@")


  _log DEBUG "${BLUE}${TOOLBOX_EXEC_LOG_PREFIX}${title}:${RESTORE}"
  _log DEBUG "${GREEN}${args}${RESTORE}"
}

function toolbox_exec {
  _toolbox_exec_log "Exec" "$@"
  exec "$@"
}

function toolbox_run {
  _toolbox_exec_log "Run" "$@"
  "$@"
}
