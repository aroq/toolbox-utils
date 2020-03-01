#!/usr/bin/env bash

# Set strict bash mode
set -euo pipefail

#  Set bash options
TOOLBOX_BASH_SET_OPTIONS=${TOOLBOX_BASH_SET_OPTIONS:-}
if [ ! -z "${TOOLBOX_BASH_SET_OPTIONS}" ]; then
  set "${TOOLBOX_BASH_SET_OPTIONS}"
fi

