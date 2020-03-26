#!/usr/bin/env bash

# shellcheck disable=SC2034

# Default varable values
export TOOLBOX_LOG_LEVEL=${TOOLBOX_LOG_LEVEL:-INFO}

RESTORE=$(echo -en '\033[0m')
RED=$(echo -en '\033[00;31m')
GREEN=$(echo -en '\033[00;32m')
YELLOW=$(echo -en '\033[00;33m')
BLUE=$(echo -en '\033[00;34m')
MAGENTA=$(echo -en '\033[00;35m')
PURPLE=$(echo -en '\033[00;35m')
CYAN=$(echo -en '\033[00;36m')
LIGHTGRAY=$(echo -en '\033[00;37m')
LRED=$(echo -en '\033[01;31m')
LGREEN=$(echo -en '\033[01;32m')
LYELLOW=$(echo -en '\033[01;33m')
LBLUE=$(echo -en '\033[01;34m')
LMAGENTA=$(echo -en '\033[01;35m')
LPURPLE=$(echo -en '\033[01;35m')
LCYAN=$(echo -en '\033[01;36m')
WHITE=$(echo -en '\033[01;37m')

function _log {
  action=$1 && shift
  case $action in
      TRACE)  [[ $TOOLBOX_LOG_LEVEL =~ TRACE ]]                 && echo "${LYELLOW}$*${RESTORE}" 1>&2 ;;
      DEBUG)  [[ $TOOLBOX_LOG_LEVEL =~ TRACE|DEBUG ]]           && echo "${LMAGENTA}$*${RESTORE}" 1>&2 ;;
      INFO)   [[ $TOOLBOX_LOG_LEVEL =~ TRACE|DEBUG|INFO ]]      && echo "${GREEN}$*${RESTORE}" 1>&2  ;;
      WARNING)   [[ $TOOLBOX_LOG_LEVEL =~ TRACE|DEBUG|INFO|WARNING ]] && echo "${YELLOW}$*${RESTORE}" 1>&2  ;;
      ERROR)  [[ ! $TOOLBOX_LOG_LEVEL =~ NONE ]]                && echo "${RED}$*${RESTORE}" 1>&2 ;;
  esac
  true;
}
