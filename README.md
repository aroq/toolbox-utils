# Bash utils for various tasks

## How to include and use

1. Clone the git repo into directory in your project
2. Include util files in your script like in the following example:
    ```
    SCRIPT_DIR="${BASH_SOURCE%/*}"
    if [[ ! -d "$SCRIPT_DIR" ]]; then SCRIPT_DIR="$PWD"; fi
    . "$SCRIPT_DIR/includes/init.sh"
    . "$SCRIPT_DIR/includes/util.sh"
    . "$SCRIPT_DIR/includes/log.sh"
    . "$SCRIPT_DIR/includes/exec.sh"
```

## Environment variables

- TOOLBOX_EXEC_LOG_PREFIX
  Default value: "---> "

- TOOLBOX_BASH_SET_OPTIONS
  Default value: *empty*

- TOOLBOX_LOG_LEVEL
  Default value: INFO

- TOOLBOX_LOG_LEVEL
  Default value: INFO
