#!/usr/bin/env bash

function _toolbox_exec_log() {
  TOOLBOX_EXEC_LOG_PREFIX=${TOOLBOX_EXEC_LOG_PREFIX-"---> "}
  TOOLBOX_EXEC_LOG_LEVEL_TITLE=${TOOLBOX_EXEC_LOG_LEVEL_TITLE-INFO}
  TOOLBOX_EXEC_LOG_LEVEL_CMD=${TOOLBOX_EXEC_LOG_LEVEL_CMD-INFO}

  local title
  title=${1:-"Execute command"}

  shift

  local args
  args=$(toolbox_util_array_join "$@")

  local _cmd_log_color="${GREEN}"
  if [ "${TOOLBOX_EXEC_LOG_LEVEL_TITLE}" = "DEBUG" ] || [ "${TOOLBOX_EXEC_LOG_LEVEL_TITLE}" = "TRACE" ]; then
    _cmd_log_color="${PURPLE}"
  fi

  _log "${TOOLBOX_EXEC_LOG_LEVEL_TITLE}" "${BLUE}${TOOLBOX_EXEC_LOG_PREFIX}${title}:${RESTORE}"
  _log "${TOOLBOX_EXEC_LOG_LEVEL_CMD}" "${_cmd_log_color}${args}${RESTORE}"
}

function toolbox_exec {
  _toolbox_exec_log "$@"
  shift
  exec "$@"
}

function toolbox_run {
  _toolbox_exec_log "$@"
  shift
  "$@"
}

function toolbox_exec_hook {
  local _context="${1}"
  local _hook="${2}"
  _log DEBUG "Check if hooks exist: toolbox/hooks/${_context}/${_hook}"
  if [[ -f "toolbox/hooks/${_context}/${_hook}" ]]; then
    _log INFO "Execute hook: toolbox/hooks/${_context}/${_hook} $*"
    . "toolbox/hooks/${_context}/${_hook}" "$@"
  fi

  if [[ -d "toolbox/hooks/${_context}/${_hook}" ]]; then
    for f in toolbox/hooks/"${_context}"/before/*
    do
      _log INFO "Execute hook: ${f} $*"
      . ${f} "$@"
    done
  fi
}
