#!/usr/bin/env bash

# shellcheck disable=SC1090

function _toolbox_exec_log() {
  local title
  title=${1:-"Execute command"}

  shift

  local args
  args=$(toolbox_util_array_join "$@")

  _toolbox_exec_log_cmd "${title}" "${args}"
}

function _toolbox_exec_log_cmd() {
  TOOLBOX_EXEC_LOG_PREFIX=${TOOLBOX_EXEC_LOG_PREFIX-"---> "}
  TOOLBOX_EXEC_LOG_LEVEL_TITLE=${TOOLBOX_EXEC_LOG_LEVEL_TITLE-INFO}
  TOOLBOX_EXEC_LOG_LEVEL_CMD=${TOOLBOX_EXEC_LOG_LEVEL_CMD-INFO}

  local title
  title=${1:-"Execute command"}

  local cmd
  cmd=${2}

  local _cmd_log_color="${GREEN}"
  if [ "${TOOLBOX_EXEC_LOG_LEVEL_TITLE}" = "DEBUG" ] || [ "${TOOLBOX_EXEC_LOG_LEVEL_TITLE}" = "TRACE" ]; then
    _cmd_log_color="${PURPLE}"
  fi

  _log "${TOOLBOX_EXEC_LOG_LEVEL_TITLE}" "${BLUE}${TOOLBOX_EXEC_LOG_PREFIX}${title}:${RESTORE}"
  _log "${TOOLBOX_EXEC_LOG_LEVEL_CMD}" "${_cmd_log_color}${cmd}${RESTORE}"
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

  TOOLBOX_TOOL_DIRS=${TOOLBOX_TOOL_DIRS:-toolbox}

  for i in ${TOOLBOX_TOOL_DIRS//,/ }
  do
    _log TRACE "Check if hooks dir exists at path: ${i}/hooks"
    if [[ -d "${i}/hooks" ]]; then
      local _hooks_path="${i}/hooks"
      _log TRACE "Check if hooks exist: ${_hooks_path}/${_context}/${_hook}"
      if [[ -f "${_hooks_path}/${_context}/${_hook}" ]]; then
        _log DEBUG "Execute hook: ${_hooks_path}/${_context}/${_hook} $*"
        (
        . "${_hooks_path}"/"${_context}"/"${_hook}" "$@"
        )
      fi

      if [[ -d "${_hooks_path}/${_context}/${_hook}" ]]; then
        for f in "${_hooks_path}"/"${_context}"/"${_hook}"/*
        do
          _log DEBUG "Execute hook: ${f} $*"
          (
          . "${f}" "$@"
          )
        done
      fi
    fi
  done

}

