#!/bin/bash

# (1) RUN schtasks /create /tn "Run OneNote Backup" /tr "wsl /home/user/Documents/tools/onenote-backup/onenote-backup.sh" /sc minute
# (2) IN TASK SCHEDULER, at "General" tab in task properties, click "Run whether user is logged on or not", "Do not store password", "Hidden"

set -e # exit on error

ENV_FILE=''
if test "$1"
then
  ENV_FILE="$1"
else
  DEFAULT_ENV_FILE="$( dirname $0 )/onenote-backup-settings.env"
  if test -f "$DEFAULT_ENV_FILE"
  then
    ENV_FILE="$DEFAULT_ENV_FILE"
  fi
fi

if test "$ENV_FILE"
then
  source "$ENV_FILE" # BASH syntax file that sets SOURCE= and DESTINATION=
fi

TIMESTAMP=$( date -u --iso-8601=seconds | tr ':' '-' )
rsync -a --log-file="$DESTINATION/$TIMESTAMP.log" --backup --backup-dir="overwritten-$TIMESTAMP" "$SOURCE/" "$DESTINATION/"

